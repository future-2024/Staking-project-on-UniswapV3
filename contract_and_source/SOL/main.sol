contract MasterChef is Ownable, ReentrancyGuard {
    using SafeMath for uint256;
    using SafeERC20 for IERC20;

    // The operator
    address private _operator;

   // Info of each Deposit.
    struct DepositInfo {
        uint256 pid;
        uint256 amount;
        uint256 lockupPeriod;
        uint256 nextWithdraw;
        uint256 accDiamondPerShare;
        uint256 taxAmount;
    }

    mapping (address=> mapping(uint256=>DepositInfo[])) public depositInfo;

    // Info of each reward.
    struct RewardInfo {
        uint256 startBlockNumber;
        uint256 endBlockNumber;
        uint256 rewardAmount;
    }

    RewardInfo[] public addRewardInfo;

    // Info of each user.
    struct UserInfo {
        uint256 amount;             // How many LP tokens the user has provided.
        uint256 nextHarvestUntil;   // When can the user harvest again.
        uint256 totalEarnedDiamond;
        uint256 taxAmount;
    }

    // Info of each pool.
    struct PoolInfo {
        IERC20 lpToken;           // Address of LP token contract.
        uint256 allocPoint;       // How many allocation points assigned to this pool. Diamonds to distribute per block.
        uint256 lastRewardBlock;  // Last block number that Diamonds distribution occurs.
        uint256 accDiamondPerShare;   // Accumulated Diamonds per share, times 1e12. See below.
        uint256 harvestInterval;  // Harvest interval in seconds
        uint256 totalAmountFromFeeByRewards;
    }
    
    // The Diamond TOKEN!
    address public diamond;
    uint256 public nextAddDiamond;
    uint256 public totalDiamondRewards;

    // Diamond tokens created per block.
    uint256 public diamondPerBlock;

    // First day and default harvest interval
    uint256 public constant DEFAULT_HARVEST_INTERVAL = 1 minutes;
    uint256 public constant MAX_HARVEST_INTERVAL = 1 days;
    uint256 public lockUpTaxRate = 2000;                        // 20%

    // Info of each pool.
    PoolInfo[] public poolInfo;

    // Info of each user that stakes LP tokens.
    mapping(uint256 => mapping(address => UserInfo)) public userInfo;

    // Total allocation points. Must be the sum of all allocation points in all pools.
    uint256 public totalAllocPoint = 0;

    mapping(uint8 => bool) public enableStaking;
    
    event Deposit(address indexed user, uint256 indexed pid, uint256 amount);
    event Withdraw(address indexed user, uint256 indexed pid, uint256 amount);
    event EmergencyWithdraw(address indexed user, uint256 indexed pid, uint256 amount);

    constructor (address _diamond) {        
        diamond = _diamond;
    }

    receive() external payable {
    }

    function setEnableStaking(uint8 _pid, bool _bEnable) external onlyOwner {
        enableStaking[_pid] = _bEnable;
    }
    
    function poolLength() external view returns (uint256) {
        return poolInfo.length;
    }

    // Add a new lp to the pool. Can only be called by the owner.
    // XXX DO NOT add the same LP token more than once. Rewards will be messed up if you do.
    function add(uint256 _allocPoint, IERC20 _lpToken, uint16 _depositFeeBP, bool _withUpdate) public onlyOwner {
        require(_depositFeeBP <= 10000, "add: invalid deposit fee basis points");
        if (_withUpdate) {
            massUpdatePools();
        }
        uint256 lastRewardBlock = block.number;
        totalAllocPoint = totalAllocPoint.add(_allocPoint);
        poolInfo.push(PoolInfo({
            lpToken: _lpToken,
            allocPoint: _allocPoint,
            lastRewardBlock: lastRewardBlock,
            accDiamondPerShare: 0,
            harvestInterval: DEFAULT_HARVEST_INTERVAL,
            totalAmountFromFeeByRewards: 0
        }));
    }

    // Update the given pool's Diamond allocation point and deposit fee. Can only be called by the owner.
    function set(uint8 _pid, uint256 _allocPoint, uint16 _depositFeeBP, bool _withUpdate) public onlyOwner {
        require(_depositFeeBP <= 10000, "set: invalid deposit fee basis points");
        
        if (_withUpdate) {
            massUpdatePools();
        }

        totalAllocPoint = totalAllocPoint.sub(poolInfo[_pid].allocPoint).add(_allocPoint);
        poolInfo[_pid].allocPoint = _allocPoint;
        poolInfo[_pid].harvestInterval = DEFAULT_HARVEST_INTERVAL;
    }

    function addRewards(uint256 _amount, uint256 _days) public onlyOwner {
        require(_amount <= IERC20(diamond).balanceOf(msg.sender), 'Deposite: Insufficient Balance of Diamond');

        uint256 period = _days.mul(1 days);
        require(block.timestamp >= nextAddDiamond, "Too early to add Diamond.");

        IERC20(diamond).safeTransferFrom(address(msg.sender), address(this), _amount);

        diamondPerBlock = _amount.div(period);
        nextAddDiamond = block.timestamp + period;
        totalDiamondRewards = totalDiamondRewards.add(_amount);

        addRewardInfo.push(RewardInfo({
            startBlockNumber: block.number,
            endBlockNumber: block.number + period,
            rewardAmount: _amount
        }));
    }

    // Return reward multiplier over the given _from to _to block.
    function getMultiplier(uint256 _from, uint256 _to) public pure returns (uint256) {
        return _to.sub(_from);
    }
    
    // Return total reward multiplier over the given _from to _to block.
    function getTotalDiamondReward() public view returns (uint256) {   
        return totalDiamondRewards;
    }
    
    // Return reward multiplier over the given _from to _to block.
    function getDiamondRewardFromBlock(uint8 _pid) public view returns (uint256) {
        PoolInfo storage pool = poolInfo[_pid];    

        uint length = addRewardInfo.length;
        uint startBlock;
        uint endBlock;
        uint rewardPerBlock;
        uint diamondReward;
        uint totalReward;
        for (uint i=0; i<length; i++) {
            startBlock = addRewardInfo[i].startBlockNumber;
            endBlock = addRewardInfo[i].endBlockNumber;
            rewardPerBlock = addRewardInfo[i].rewardAmount.div(endBlock.sub(startBlock));
            if (endBlock <= pool.lastRewardBlock)
                continue;

            if (startBlock < pool.lastRewardBlock && endBlock < block.number) {
                diamondReward = (endBlock.sub(pool.lastRewardBlock)).mul(rewardPerBlock);
            }
            else if (startBlock < pool.lastRewardBlock && endBlock >= block.number) {
                diamondReward = (block.number.sub(pool.lastRewardBlock)).mul(rewardPerBlock);
            }
            else if (startBlock >= pool.lastRewardBlock && endBlock <= block.number) {
                diamondReward = addRewardInfo[i].rewardAmount;
            }
            else if (startBlock >= pool.lastRewardBlock && endBlock > block.number) {
                diamondReward = (block.number.sub(startBlock)).mul(rewardPerBlock);
            }

            totalReward = totalReward.add(diamondReward);
        }

        return totalReward;
    }

    function getTotalDiamondRewardFromBlock() public view returns (uint256) {
        uint length = addRewardInfo.length;
        uint startBlock;
        uint endBlock;
        uint rewardPerBlock;
        uint diamondReward;
        uint totalReward;
        for (uint i=0; i<length; i++) {
            startBlock = addRewardInfo[i].startBlockNumber;
            endBlock = addRewardInfo[i].endBlockNumber;
            rewardPerBlock = addRewardInfo[i].rewardAmount.div(endBlock.sub(startBlock));

            if (endBlock < block.number) {
                diamondReward = addRewardInfo[i].rewardAmount;
            }
            else {
                diamondReward = (block.number.sub(startBlock)).mul(rewardPerBlock);
            }

            totalReward = totalReward.add(diamondReward);
        }

        return totalReward;
    }

    function pendingDiamondForDeposit(uint8 _pid, address _user, int256 _depositIndex) 
        public view returns (uint256 totalPending, uint256 claimablePending) {
        PoolInfo storage pool = poolInfo[_pid];
        uint256 lpSupply = pool.lpToken.balanceOf(address(this));

        if (lpSupply == 0) {
            return (0, 0);
        }

        uint256 accDiamondPerShare = pool.accDiamondPerShare;

        if (block.number > pool.lastRewardBlock && lpSupply != 0) {
            uint256 diamondReward = getDiamondRewardFromBlock(_pid).mul(pool.allocPoint).div(totalAllocPoint);
            diamondReward = diamondReward.add(pool.totalAmountFromFeeByRewards);

            accDiamondPerShare = accDiamondPerShare.add(diamondReward.mul(1e12).div(lpSupply));
        }

        if (_depositIndex >= 0) {
            (uint256 _totalPending, uint256 _claimablePending, ) = 
                availableIndividualRewardsForHarvest(_pid, _user, accDiamondPerShare, uint256(_depositIndex));

            totalPending = _totalPending;
            claimablePending = _claimablePending;
        }
        else {
            (uint256 _totalPending, uint256 _claimablePending, ) = 
                availableRewardsForHarvest(_pid, _user, accDiamondPerShare);

            totalPending = _totalPending;
            claimablePending = _claimablePending;
        }
    }

    function getEarnedTokenInfo(uint8 _pid, address _user) external view 
        returns (uint256[] memory, uint256[] memory) {
        DepositInfo[] memory myDeposits =  depositInfo[_user][_pid];

        uint256[] memory totalPendingTokenInfo = new uint256[](myDeposits.length);
        uint256[] memory claimablePendingTokenInfo = new uint256[](myDeposits.length);

        for(uint256 i=0; i< myDeposits.length; i++) {
            (uint256 totalAmount, uint256 pendingAmount) = pendingDiamondForDeposit(_pid, _user, int256(i));
            totalPendingTokenInfo[i] = totalAmount;
            claimablePendingTokenInfo[i] = pendingAmount;
        }

        return (totalPendingTokenInfo, claimablePendingTokenInfo);
    }

    // View function to see if user can harvest BloqBalls.
    function canHarvest(uint8 _pid, address _user) public view returns (bool) {
        UserInfo storage user = userInfo[_pid][_user];
        return block.timestamp >= user.nextHarvestUntil;
    }
    
    // View function to see user's deposit info.
    function getDepositInfo(uint8 _pid, address _user) public view returns (DepositInfo[] memory) {
        return depositInfo[_user][_pid];
    }

    // Update reward variables for all pools. Be careful of gas spending!
    function massUpdatePools() public {
        uint256 length = poolInfo.length;
        for (uint8 pid = 0; pid < length; ++pid) {
            updatePool(pid);
        }
    }

    // Update reward variables of the given pool to be up-to-date.
    function updatePool(uint8 _pid) public {
        require(enableStaking[_pid] == true, 'Deposite: DISABLE DEPOSITING');

        PoolInfo storage pool = poolInfo[_pid];
        if (block.number <= pool.lastRewardBlock) {
            return;
        }
        uint256 lpSupply = pool.lpToken.balanceOf(address(this));

        if (lpSupply == 0 || pool.allocPoint == 0) {
            pool.lastRewardBlock = block.number;
            return;
        }

        uint256 diamondReward = getDiamondRewardFromBlock(_pid).mul(pool.allocPoint).div(totalAllocPoint);

        diamondReward = diamondReward.add(pool.totalAmountFromFeeByRewards);
        pool.totalAmountFromFeeByRewards = 0;

        pool.accDiamondPerShare = pool.accDiamondPerShare.add(diamondReward.mul(1e12).div(lpSupply));
        pool.lastRewardBlock = block.number;
    }

    // Deposit LP tokens to MasterChef for Diamond allocation.
    function deposit(uint8 _pid, uint256 _amount) public nonReentrant {
        require(enableStaking[_pid] == true, 'Deposite: DISABLE DEPOSITING');
        require(_amount > 0, 'Deposite: DISABLE DEPOSITING');
        
        PoolInfo storage pool = poolInfo[_pid];
        UserInfo storage user = userInfo[_pid][msg.sender];

        updatePool(_pid);

        pool.lpToken.safeTransferFrom(address(msg.sender), address(this), _amount);
        user.amount = user.amount.add(_amount);

        depositInfo[msg.sender][_pid].push(DepositInfo({
            pid: _pid,
            amount: _amount,
            lockupPeriod:MAX_HARVEST_INTERVAL,
            nextWithdraw: block.timestamp.add(MAX_HARVEST_INTERVAL),
            accDiamondPerShare: pool.accDiamondPerShare,
            taxAmount: 0
        }));

        if (user.nextHarvestUntil == 0) {
            user.nextHarvestUntil = block.timestamp.add(MAX_HARVEST_INTERVAL);
        }

        emit Deposit(msg.sender, _pid, _amount);
    }

    // Harvest rewards.
    function harvest(uint8 _pid) public nonReentrant {
        require(enableStaking[_pid] == true, 'Deposite: DISABLE DEPOSITING');

        updatePool(_pid);
        payOrLockupPendingDiamond(_pid, -1);
    }

    function harvestForDeposit(uint8 _pid, int256 _depositIndex) public nonReentrant {
        require(enableStaking[_pid] == true, 'Deposite: DISABLE DEPOSITING');

        updatePool(_pid);
        payOrLockupPendingDiamond(_pid, _depositIndex);
    }

    function availableIndividualRewardsForHarvest (uint8 _pid, address _user, uint256 accPerShare, uint256 depositIndex) 
            public view returns (uint256 totalRewardAmount, uint256 rewardAmount, uint256 taxAmount) {
        uint256 rewardRate;
        uint256 rewardDebt;

        PoolInfo storage pool = poolInfo[_pid];
        UserInfo storage user = userInfo[_pid][_user];
        DepositInfo memory myDeposit =  depositInfo[_user][_pid][depositIndex];

        accPerShare = accPerShare.sub(user.taxAmount.mul(1e12).div(pool.lpToken.balanceOf(address(this))));

        rewardDebt =  myDeposit.amount.mul(myDeposit.accDiamondPerShare).div(1e12);
        totalRewardAmount = myDeposit.amount.mul(accPerShare).div(1e12);

        if (rewardDebt > totalRewardAmount) {       // no rewards yet
            return (0, 0, 0);
        }

        totalRewardAmount = totalRewardAmount.sub(rewardDebt);

        if (myDeposit.nextWithdraw > block.timestamp) {
            return (totalRewardAmount, 0, 0);
        }

        rewardRate = calculateRewardRate(_pid, _user, depositIndex);     
        taxAmount = totalRewardAmount.mul(rewardRate).div(10000);
        rewardAmount = totalRewardAmount.sub(taxAmount);
    }

    function availableRewardsForHarvest(uint8 _pid, address _user, uint256 accPerShare) 
            public view returns (uint256 totalRewardAmount, uint256 rewardAmount, uint256 taxAmount) {
        uint256 totalRewards;
        uint256 rewardRate;
        uint256 rewardDebt;
        uint256 totalRewardDebt;

        PoolInfo storage pool = poolInfo[_pid];
        UserInfo storage user = userInfo[_pid][_user];
        DepositInfo[] memory myDeposits =  depositInfo[_user][_pid];

        accPerShare = accPerShare.sub(user.taxAmount.mul(1e12).div(pool.lpToken.balanceOf(address(this))));

        for(uint256 i=0; i< myDeposits.length; i++) {
            rewardDebt = (myDeposits[i].amount).mul(myDeposits[i].accDiamondPerShare).div(1e12);
            totalRewardDebt = totalRewardDebt.add(rewardDebt);

            if (myDeposits[i].nextWithdraw > block.timestamp) {
                continue;
            }

            totalRewards = (myDeposits[i].amount).mul(accPerShare).div(1e12);
            totalRewards = totalRewards.sub(rewardDebt);          

            rewardRate = calculateRewardRate(_pid, _user, i);     
            taxAmount = taxAmount.add(totalRewards.mul(rewardRate).div(10000));
            rewardAmount = rewardAmount.add(totalRewards.sub(totalRewards.mul(rewardRate).div(10000)));
        }

        totalRewardAmount = user.amount.mul(accPerShare).div(1e12).sub(totalRewardDebt);
    }

    function updateDepositInfo(uint8 _pid, address _user, int256 _depositIndex) public {
        PoolInfo storage pool = poolInfo[_pid];

        if (_depositIndex >= 0) {
            DepositInfo memory myDeposit = depositInfo[_user][_pid][uint256(_depositIndex)];

            if(myDeposit.nextWithdraw < block.timestamp) {
                depositInfo[_user][_pid][uint256(_depositIndex)].accDiamondPerShare = pool.accDiamondPerShare;
            }
        }
        else {
            DepositInfo[] memory myDeposits = depositInfo[_user][_pid];

            for(uint256 i=0; i< myDeposits.length; i++) {
                if(myDeposits[i].nextWithdraw < block.timestamp) {
                    depositInfo[_user][_pid][i].accDiamondPerShare = pool.accDiamondPerShare;
                }
            }
        }
    }

    function getTaxInfo(uint8 _pid, address _user) external view returns (uint256[] memory) {
        DepositInfo[] memory myDeposits =  depositInfo[_user][_pid];

        uint256[] memory taxInfo = new uint256[](myDeposits.length);

        for(uint256 i=0; i< myDeposits.length; i++) {
            taxInfo[i] = calculateRewardRate(_pid, _user, i);
        }

        return taxInfo;
    }

    function calculateRewardRate(uint8 _pid, address _user, uint256 _depositIndex) 
            public view returns (uint256 rewardRate) {
        DepositInfo storage myDeposit =  depositInfo[_user][_pid][_depositIndex];

        if (block.timestamp < myDeposit.nextWithdraw)
            return lockUpTaxRate;

        uint256 elapsedTime = block.timestamp.sub(myDeposit.nextWithdraw);

        uint256 interval = elapsedTime.div(MAX_HARVEST_INTERVAL);

        if (lockUpTaxRate > (interval.add(1)).mul(100))
            rewardRate = lockUpTaxRate.sub((interval.add(1)).mul(100));
        else 
            rewardRate = 0;
    }

    function availableForWithdraw(address _user, uint8 _pid) public view returns (uint256 totalAmount) {
        totalAmount = 0;
        DepositInfo[] memory myDeposits =  depositInfo[_user][_pid];
        for(uint256 i=0; i< myDeposits.length; i++) {
            if(myDeposits[i].nextWithdraw < block.timestamp) {
                totalAmount = totalAmount.add(myDeposits[i].amount);
            }
        }
    }

    // Withdraw LP tokens from MasterChef.
    function withdraw(uint8 _pid, uint256 _amount) public nonReentrant {
        require(enableStaking[_pid] == true, 'Withdraw: DISABLE WITHDRAWING');
        
        PoolInfo storage pool = poolInfo[_pid];
        UserInfo storage user = userInfo[_pid][msg.sender];

        require(user.amount >= _amount, "withdraw: not good");

        uint256 availableAmount = availableForWithdraw(msg.sender, _pid);
        require(availableAmount > 0, "withdraw: no available amount");

        if (availableAmount < _amount) {
            _amount = availableAmount;
        }

        updatePool(_pid);
        payOrLockupPendingDiamond(_pid, -1);

        if (_amount > 0) {
            user.amount = user.amount.sub(_amount);
            pool.lpToken.safeTransfer(address(msg.sender), _amount);
        }

        // Remove desosit info in the array
        removeAmountFromDeposits(msg.sender, _pid, _amount, block.timestamp);
        removeEmptyDeposits(msg.sender, _pid);
        
        emit Withdraw(msg.sender, _pid, _amount);
    }

    // Withdraw without caring about rewards. EMERGENCY ONLY.
    function emergencyWithdraw(uint8 _pid) public nonReentrant {
        require(enableStaking[_pid] == true, 'Withdraw: DISABLE WITHDRAWING');
        
        PoolInfo storage pool = poolInfo[_pid];
        UserInfo storage user = userInfo[_pid][msg.sender];
        uint256 amount = user.amount;
        user.amount = 0;
        user.nextHarvestUntil = 0;
        pool.lpToken.safeTransfer(address(msg.sender), amount);
        emit EmergencyWithdraw(msg.sender, _pid, amount);
    }

    // Pay or lockup pending BloqBalls.
    function payOrLockupPendingDiamond(uint8 _pid, int256 _depositIndex) public {
        require(enableStaking[_pid] == true, 'Withdraw: DISABLE WITHDRAWING');
        
        PoolInfo storage pool = poolInfo[_pid];
        UserInfo storage user = userInfo[_pid][msg.sender];

        uint256 claimablePending;
        uint256 taxPending;

        if (_depositIndex >= 0) {
            (, uint256 _claimablePending, uint256 _taxPending) = 
                availableIndividualRewardsForHarvest(_pid, msg.sender, pool.accDiamondPerShare, uint256(_depositIndex));

            claimablePending = _claimablePending;
            taxPending = _taxPending;
        }
        else {
            (, uint256 _claimablePending, uint256 _taxPending) = 
                availableRewardsForHarvest(_pid, msg.sender, pool.accDiamondPerShare);

            claimablePending = _claimablePending;
            taxPending = _taxPending;        
        }

        if (canHarvest(_pid, msg.sender)) {
            if (claimablePending > 0) {
                pool.totalAmountFromFeeByRewards = pool.totalAmountFromFeeByRewards.add(taxPending);
                user.nextHarvestUntil = block.timestamp.add(pool.harvestInterval);

                // send Diamond rewards
                safeDiamondTransfer(msg.sender, claimablePending);

                user.totalEarnedDiamond = user.totalEarnedDiamond.add(claimablePending);
                user.taxAmount = taxPending;

                updateDepositInfo(_pid, msg.sender, _depositIndex);
            }
        }
    }
    
    // Safe Diamond transfer function, just in case if rounding error causes pool to not have enough BloqBalls.
    function safeDiamondTransfer(address _to, uint256 _amount) internal {   
        uint256 diamondBalance = IERC20(diamond).balanceOf(address(this));
        if (_amount > diamondBalance) {
            IERC20(diamond).transfer(_to, diamondBalance);
        } else {
            IERC20(diamond).transfer(_to, _amount);
        }
    }
    
    function setLockUpTaxRate(uint256 _limit) public onlyOwner {
        require(_limit <= 10000, 'Limit Period: can not over 100%');
        lockUpTaxRate = _limit;
    }

    function removeAmountFromDeposits(address _user, uint8 _pid, uint256 _amount, uint256 _time) public {
        uint256 length =  depositInfo[_user][_pid].length;

        for(uint256 i=0; i< length; i++) {
            if(depositInfo[_user][_pid][i].nextWithdraw < _time) {
                if (depositInfo[_user][_pid][i].amount <= _amount) {
                    _amount = _amount.sub(depositInfo[_user][_pid][i].amount);
                    depositInfo[_user][_pid][i].amount = 0;
                }
                else {
                    depositInfo[_user][_pid][i].amount = depositInfo[_user][_pid][i].amount.sub(_amount);
                    _amount = 0;
                }
            }

            if (_amount == 0) {
                break;
            }
        }
    }

    function removeEmptyDeposits(address user, uint8 _pid) public {
        for (uint256 i=0; i<depositInfo[user][_pid].length; i++) {
            while(depositInfo[user][_pid].length > 0 && depositInfo[user][_pid][i].amount  == 0) {
                for (uint256 j = i; j<depositInfo[user][_pid].length-1; j++) {
                    depositInfo[user][_pid][j] = depositInfo[user][_pid][j+1];
                }
                depositInfo[user][_pid].pop();
            }
        }
    }
}