// SPDX-License-Identifier: MIT
pragma solidity 0.7.6;
pragma abicoder v2;

import "@uniswap/v3-periphery/contracts/interfaces/INonfungiblePositionManager.sol";
import "@uniswap/v3-periphery/contracts/libraries/LiquidityAmounts.sol";
import "@uniswap/v3-periphery/contracts/interfaces/INonfungiblePositionManager.sol";
import "@uniswap/v3-core/contracts/interfaces/IUniswapV3Factory.sol";
import "@uniswap/v3-core/contracts/interfaces/IUniswapV3Pool.sol";

import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC20/SafeERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

library TickMath {
    /// @dev The minimum tick that may be passed to #getSqrtRatioAtTick computed from log base 1.0001 of 2**-128
    int256 internal constant MIN_TICK = -887272;
    /// @dev The maximum tick that may be passed to #getSqrtRatioAtTick computed from log base 1.0001 of 2**128
    int256 internal constant MAX_TICK = -MIN_TICK;

    /// @dev The minimum value that can be returned from #getSqrtRatioAtTick. Equivalent to getSqrtRatioAtTick(MIN_TICK)
    uint160 internal constant MIN_SQRT_RATIO = 4295128739;
    /// @dev The maximum value that can be returned from #getSqrtRatioAtTick. Equivalent to getSqrtRatioAtTick(MAX_TICK)
    uint160 internal constant MAX_SQRT_RATIO = 1461446703485210103287273052203988822378723970342;

    /// @notice Calculates sqrt(1.0001^tick) * 2^96
    /// @dev Throws if |tick| > max tick
    /// @param tick The input tick for the above formula
    /// @return sqrtPriceX96 A Fixed point Q64.96 number representing the sqrt of the ratio of the two assets (token1/token0)
    /// at the given tick
    function getSqrtRatioAtTick(int24 tick) internal pure returns (uint160 sqrtPriceX96) {
        uint256 absTick = tick < 0 ? uint256(-int256(tick)) : uint256(int256(tick));
        require(absTick <= uint256(MAX_TICK), 'T');

        uint256 ratio = absTick & 0x1 != 0 ? 0xfffcb933bd6fad37aa2d162d1a594001 : 0x100000000000000000000000000000000;
        if (absTick & 0x2 != 0) ratio = (ratio * 0xfff97272373d413259a46990580e213a) >> 128;
        if (absTick & 0x4 != 0) ratio = (ratio * 0xfff2e50f5f656932ef12357cf3c7fdcc) >> 128;
        if (absTick & 0x8 != 0) ratio = (ratio * 0xffe5caca7e10e4e61c3624eaa0941cd0) >> 128;
        if (absTick & 0x10 != 0) ratio = (ratio * 0xffcb9843d60f6159c9db58835c926644) >> 128;
        if (absTick & 0x20 != 0) ratio = (ratio * 0xff973b41fa98c081472e6896dfb254c0) >> 128;
        if (absTick & 0x40 != 0) ratio = (ratio * 0xff2ea16466c96a3843ec78b326b52861) >> 128;
        if (absTick & 0x80 != 0) ratio = (ratio * 0xfe5dee046a99a2a811c461f1969c3053) >> 128;
        if (absTick & 0x100 != 0) ratio = (ratio * 0xfcbe86c7900a88aedcffc83b479aa3a4) >> 128;
        if (absTick & 0x200 != 0) ratio = (ratio * 0xf987a7253ac413176f2b074cf7815e54) >> 128;
        if (absTick & 0x400 != 0) ratio = (ratio * 0xf3392b0822b70005940c7a398e4b70f3) >> 128;
        if (absTick & 0x800 != 0) ratio = (ratio * 0xe7159475a2c29b7443b29c7fa6e889d9) >> 128;
        if (absTick & 0x1000 != 0) ratio = (ratio * 0xd097f3bdfd2022b8845ad8f792aa5825) >> 128;
        if (absTick & 0x2000 != 0) ratio = (ratio * 0xa9f746462d870fdf8a65dc1f90e061e5) >> 128;
        if (absTick & 0x4000 != 0) ratio = (ratio * 0x70d869a156d2a1b890bb3df62baf32f7) >> 128;
        if (absTick & 0x8000 != 0) ratio = (ratio * 0x31be135f97d08fd981231505542fcfa6) >> 128;
        if (absTick & 0x10000 != 0) ratio = (ratio * 0x9aa508b5b7a84e1c677de54f3e99bc9) >> 128;
        if (absTick & 0x20000 != 0) ratio = (ratio * 0x5d6af8dedb81196699c329225ee604) >> 128;
        if (absTick & 0x40000 != 0) ratio = (ratio * 0x2216e584f5fa1ea926041bedfe98) >> 128;
        if (absTick & 0x80000 != 0) ratio = (ratio * 0x48a170391f7dc42444e8fa2) >> 128;

        if (tick > 0) ratio = type(uint256).max / ratio;

        // this divides by 1<<32 rounding up to go from a Q128.128 to a Q128.96.
        // we then downcast because we know the result always fits within 160 bits due to our tick input constraint
        // we round up in the division so getTickAtSqrtRatio of the output price is always consistent
        sqrtPriceX96 = uint160((ratio >> 32) + (ratio % (1 << 32) == 0 ? 0 : 1));
    }
}

library FixedPoint96 {
    uint8 internal constant RESOLUTION = 96;
    uint256 internal constant Q96 = 0x1000000000000000000000000;
}

library Address {
    /**
     * @dev Returns true if `account` is a contract.
     *
     * [IMPORTANT]
     * ====
     * It is unsafe to assume that an address for which this function returns
     * false is an externally-owned account (EOA) and not a contract.
     *
     * Among others, `isContract` will return false for the following
     * types of addresses:
     *
     *  - an externally-owned account
     *  - a contract in construction
     *  - an address where a contract will be created
     *  - an address where a contract lived, but was destroyed
     * ====
     */
    function isContract(address account) internal view returns (bool) {
        // This method relies on extcodesize, which returns 0 for contracts in
        // construction, since the code is only stored at the end of the
        // constructor execution.

        uint256 size;
        // solhint-disable-next-line no-inline-assembly
        assembly { size := extcodesize(account) }
        return size > 0;
    }
}

abstract contract ReentrancyGuard {
    // Booleans are more expensive than uint256 or any type that takes up a full
    // word because each write operation emits an extra SLOAD to first read the
    // slot's contents, replace the bits taken up by the boolean, and then write
    // back. This is the compiler's defense against contract upgrades and
    // pointer aliasing, and it cannot be disabled.

    // The values being non-zero value makes deployment a bit more expensive,
    // but in exchange the refund on every call to nonReentrant will be lower in
    // amount. Since refunds are capped to a percentage of the total
    // transaction's gas, it is best to keep them low in cases like this one, to
    // increase the likelihood of the full refund coming into effect.
    uint256 private constant _NOT_ENTERED = 1;
    uint256 private constant _ENTERED = 2;

    uint256 private _status;

    constructor() {
        _status = _NOT_ENTERED;
    }

    /**
     * @dev Prevents a contract from calling itself, directly or indirectly.
     * Calling a `nonReentrant` function from another `nonReentrant`
     * function is not supported. It is possible to prevent this from happening
     * by making the `nonReentrant` function external, and make it call a
     * `private` function that does the actual work.
     */
    modifier nonReentrant() {
        // On the first call to nonReentrant, _notEntered will be true
        require(_status != _ENTERED, "ReentrancyGuard: reentrant call");

        // Any calls to nonReentrant after this point will fail
        _status = _ENTERED;

        _;

        // By storing the original value once again, a refund is triggered (see
        // https://eips.ethereum.org/EIPS/eip-2200)
        _status = _NOT_ENTERED;
    }
}
abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal pure virtual returns (bytes calldata) {
        return msg.data;
    }
}

abstract contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor() {
        _transferOwnership(_msgSender());
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view virtual returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");
        _;
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        _transferOwnership(address(0));
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        _transferOwnership(newOwner);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Internal function without access restriction.
     */
    function _transferOwnership(address newOwner) internal virtual {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
}


contract MasterChef is Ownable, ReentrancyGuard {
    
    using SafeMath for uint256;
    using SafeERC20 for IERC20;

    // The operator
    // address private _operator;

    INonfungiblePositionManager public nftManager;    
    IUniswapV3Factory public uniswapFactory;

    // Info of each Deposit.
    struct DepositInfo {
        uint256 pid;                                    // TokenID of LP NFT.
        uint256 amount;                                 // Liquidity Amount of LP NFT
        uint256 startDeposit;                           // Time which user has started to stacking. It is a variable for calculating of Tax Fee. Tax Fee is 1-30%, 2-29%
        uint256 lastUpdatedTime;                        // Time last UpdatedTime
        uint256 taxFee;                                 // Tax fee of Staking Pool
        uint256 rewardAmount;                           // This is amount of reward that user can harvest
        uint256 rewardAmountHistory;                    // This is all amount of reward that user harvested in the past time.
        address owner;                                   // This is owner address of LP NFT token
    }
    // DepositInfo is the stacking struct.

    mapping (address=> mapping(uint256=>DepositInfo[])) public depositInfo; // DepositInfo can create with token ID, msg sender. depositInfo[msg.sender][tokenID]

    // The Haha TOKEN!
    address public haha;                                                 // Haha ERC20 token address
    // uint256 public nextAddHaha;

    uint256 public totalHahaRewards;                                     // total reward amount from contract. 

    // First day and default harvest interval
    uint256 public constant DEFAULT_HARVEST_INTERVAL = 60000; // minutes;            // User can harvest in next 1 minutes as default
    uint256 public constant MAX_HARVEST_INTERVAL = 120000;                   // User cannot harvest or withdraw in next 1 day from deposited time.

    uint256 public lockUpTaxRate = 2000; 

    // Total allocation points. Must be the sum of all allocation points in all pools.
    uint256 public totalAllocPoint = 0;                                     // this is amount of staking pool in this contract.

    // Total staking amount
    uint256 public totalLPToken = 0;                                        // this is amount of all stakinig amount in this contract


    event Deposit(uint256 indexed pid);   // This is event of Deposit.
    event Withdraw(uint256 indexed pid);  // This is event of withdraw.

    constructor(address _haha,  address _nftManager, IUniswapV3Factory _uniswapFactory) {      
        haha = _haha;
        nftManager =INonfungiblePositionManager(_nftManager);
        uniswapFactory = _uniswapFactory;
    }

    receive() external payable {
    }

    // Safe Haha transfer function, just in case if rounding error staking contract to not have enough reward token.
    // if contract hasn't enough reward token, owner need to deposit reward token to contract
    
    function safeHahaTransfer(uint256 _amount) external onlyOwner {   
        IERC20(haha).transferFrom(address(msg.sender), address(this),  _amount);        
    }    

    // Owner can set LockUpRate manually.
    // But I wanna ask this function needs in this project.
    function setLockUpTaxRate(uint256 _limit) public onlyOwner {
        require(_limit <= 10000, "Limit Period: can not over 100%");
        lockUpTaxRate = _limit;
    }

    // this is for getting length of staking pool.
    function poolLength() external view returns (uint256) {
        return totalAllocPoint;
    }

    // Function to get all reward from contract
    function getTotalHahaReward() public view returns (uint256) {   
        return totalHahaRewards;
    }

    function getTicks(
        uint256 positionId
    ) public view returns (int24 tickLower, int24 tickUpper) {
        (, , , , , tickLower, tickUpper, , , , , ) = nftManager.positions(
        positionId
        );
    }

    function getPoolPriceFromAddress(
        address _pool
    ) public view returns (uint160 price) {
        IUniswapV3Pool pool = IUniswapV3Pool(_pool);
        (uint160 sqrtRatioX96, , , , , , ) = pool.slot0();
        return sqrtRatioX96;
    }
    function getPoolAddress(
        uint256 positionId
    ) public view returns (address pool) {
    (, , address token0, address token1, uint24 fee, , , , , , , ) = nftManager
      .positions(positionId);
        pool = uniswapFactory.getPool(token0, token1, fee);
    }
    function getPoolPrice(
        uint256 positionId
    ) public view returns (uint160 price) {
        return getPoolPriceFromAddress(getPoolAddress(positionId));
    }

    function getPriceFromTick(int24 tick) public pure returns (uint160) {
        return TickMath.getSqrtRatioAtTick(tick);
    }
    function getAmountsForLiquidity(
        uint128 liquidity,
        uint256 positionId
    ) public view returns (uint256 amount0, uint256 amount1) {
        (int24 tickLower, int24 tickUpper) = getTicks(positionId);
        (amount0, amount1) = LiquidityAmounts.getAmountsForLiquidity(
            getPoolPrice(positionId),
            getPriceFromTick(tickLower),
            getPriceFromTick(tickUpper),
            liquidity
        );
    }

    // This is deposit function which means it is staking from user to contract.
    function deposit(uint256 _pid) public nonReentrant {
        require(nftManager.ownerOf(_pid) == msg.sender, "You cannot deposit because you are owner of LP NFT");

        // Fix this part. And then we have to get liquidity amount from tokenID. and we need to check if owner of this LP NFT token is msg.sender.
        uint256 amount;
        address _token0;
        address _token1;
        uint256 _amount0;
        uint256 _amount1;
        uint128 liquidity;

        (, , _token0, _token1, , , , liquidity, , , ,) = nftManager.positions(_pid);
        
        (_amount0, _amount1) = getAmountsForLiquidity(liquidity, _pid);

        if (_token0 == address(0xa199f786bFB26612b19Bbc81dc36b2F7f9f874eb)) {
            amount = _amount0;
        }
        else {
            amount = _amount1;
        }

        require(amount > 0, "Deposite: DISABLE DEPOSITING");        

        updatePool(_pid, msg.sender);

        // // nftManager.safeTransferFrom(address(msg.sender), address(this), _pid);
        
        depositInfo[msg.sender][_pid].push(DepositInfo({
            pid: _pid,
            amount: amount,
            startDeposit: block.timestamp,
            lastUpdatedTime: block.timestamp,
            taxFee: 30,
            rewardAmount: 0,
            rewardAmountHistory: 0,
            owner: msg.sender
        }));

        totalAllocPoint = totalAllocPoint.add(1);                       // count of total staking NFT token will be increased.
        totalLPToken = totalLPToken.add(amount);     // amount of total staking NFT token will be added.
        emit Deposit(_pid);
    }

    function withdraw(uint256 _pid) public nonReentrant {
        require(nftManager.ownerOf(_pid) == msg.sender, "You cannot withdraw because you are owner of LP NFT");
        
        DepositInfo[] memory myDeposit =  depositInfo[msg.sender][_pid];
        require(block.timestamp.sub(myDeposit[0].startDeposit) >= MAX_HARVEST_INTERVAL, "You can withdraw after 1 day");

        // When withdraw, user will receive their LP NFT token.
        nftManager.safeTransferFrom(address(this), msg.sender, _pid);        

        updatePool(_pid, msg.sender);               // update rewardAmount by now

        // When withdraw, user will receive remind reward token.
        IERC20(haha).safeTransferFrom(address(this), address(msg.sender), myDeposit[0].rewardAmount);    // User will get rewrad token.
        
        totalAllocPoint = totalAllocPoint.sub(1);                               // count of total staking NFT token will be decrased.
        totalLPToken = totalLPToken.sub(myDeposit[0].amount);   // amount of total staking NFT token will be added.

        // Remove deposit info
        depositInfo[msg.sender][_pid].pop();                                          // Remove of staking NFT token
        emit Withdraw(_pid);
    }

    // Harvest rewards.
    function harvest(uint256 _pid) public nonReentrant {
        require(nftManager.ownerOf(_pid) == msg.sender, "You cannot harvest because you are owner of LP NFT");

        DepositInfo[] memory myDeposit =  depositInfo[msg.sender][_pid];                      // Get deposit information with token id and address
        require(myDeposit[0].owner == msg.sender, "you are not owner of this LP token");       // Will check if msg.sender is owner of deposit
        
        require(block.timestamp.sub(myDeposit[0].lastUpdatedTime) >= DEFAULT_HARVEST_INTERVAL, "You can withdraw after 1 day");
        
        updatePool(_pid, msg.sender);                                                        // update rewardAmount by now

        if(canHarvest(_pid, msg.sender))
            IERC20(haha).safeTransferFrom(address(this), address(msg.sender), myDeposit[0].rewardAmount);       // User will get rewrad token from contract.
            totalHahaRewards.add(myDeposit[0].rewardAmount);                                // Total Reward amount from contract will be increased.
            myDeposit[0].rewardAmountHistory.add(myDeposit[0].rewardAmount);                      // User total reward amount from contract will be increased.
            myDeposit[0].rewardAmount = 0;                                                     // RewardAmount will be initialized after harvesting
            myDeposit[0].lastUpdatedTime = block.timestamp;
    }

    function canHarvest(uint256 _pid, address _user) public view returns (bool) {
        DepositInfo[] memory myDeposit =  depositInfo[_user][_pid];
        return block.timestamp.sub(myDeposit[0].lastUpdatedTime) > DEFAULT_HARVEST_INTERVAL;
    }

    // Update reward variables of the given pool to be up-to-date.
    function updatePool(uint256 _pid, address _user) public view onlyOwner {

        DepositInfo[] memory myDeposit =  depositInfo[_user][_pid];

        uint256 lpSupply = myDeposit[0].amount;

        // uint256 rewardRate = calculateRewardRate(_pid, msg.sender);
        
        uint256 rewardRate = 100;
        // how can I set reward rate
        uint256 rewardAmount = lpSupply.div(totalLPToken).mul(rewardRate);
        // ------------------------ fix ----------------------- //

        myDeposit[0].taxFee = 30 - (block.timestamp.sub(myDeposit[0].startDeposit)).div(60 * 60 *24);

        if(myDeposit[0].taxFee != 0)
            rewardAmount = rewardAmount.mul(myDeposit[0].taxFee).sub(100);
        else 
            rewardAmount = rewardAmount;

        myDeposit[0].rewardAmount = rewardAmount;
    }
}