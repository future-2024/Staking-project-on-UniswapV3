// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Import Uniswap V3 interfaces
import '@uniswap/v3-periphery/contracts/interfaces/INonfungiblePositionManager.sol';
import '@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol';
import '@openzeppelin/contracts/utils/math/SafeMath.sol';
import '@openzeppelin/contracts/access/Ownable.sol';

contract MasterChefV3 is Ownable, IERC721Receiver {
    using SafeMath for uint256;

    // Uniswap V3 position manager contract
    INonfungiblePositionManager public positionManager;

    struct UserInfo {
        uint256 totalEarnedRewards;
        uint256 nextHarvestUntil;
        uint256 totalNFTs; // Track how many NFTs a user owns
    }

    struct PoolInfo {
        uint256 allocPoint; // How many allocation points for the pool
        uint256 lastRewardBlock; // Last block that rewards were distributed
        uint256 accRewardPerShare; // Accumulated rewards per share
        uint256 totalNFTs; // Total NFTs in the pool
    }

    // Track user information and positions by token ID
    mapping(address => UserInfo) public userInfo;
    mapping(uint256 => address) public positionOwners; // tokenID -> owner

    PoolInfo public poolInfo;

    // Events
    event Deposit(address indexed user, uint256 indexed tokenId);
    event Withdraw(address indexed user, uint256 indexed tokenId);

    constructor(address _positionManager) {
        positionManager = INonfungiblePositionManager(_positionManager);
    }

    // Override ERC721Receiver to allow receiving NFTs
    function onERC721Received(
        address operator,
        address from,
        uint256 tokenId,
        bytes calldata data
    ) external override returns (bytes4) {
        require(msg.sender == address(positionManager), "Only Uniswap V3 NFTs allowed");
        return this.onERC721Received.selector;
    }

    // Deposit Uniswap V3 NFT representing a liquidity position
    function deposit(uint256 tokenId) external {
        // Transfer NFT to this contract
        positionManager.safeTransferFrom(msg.sender, address(this), tokenId);

        // Update user and pool information
        userInfo[msg.sender].totalNFTs = userInfo[msg.sender].totalNFTs.add(1);
        poolInfo.totalNFTs = poolInfo.totalNFTs.add(1);
        positionOwners[tokenId] = msg.sender;

        emit Deposit(msg.sender, tokenId);
    }

    // Withdraw NFT representing liquidity position
    function withdraw(uint256 tokenId) external {
        require(positionOwners[tokenId] == msg.sender, "Not the owner of this position");

        // Transfer NFT back to the user
        positionManager.safeTransferFrom(address(this), msg.sender, tokenId);

        // Update user and pool information
        userInfo[msg.sender].totalNFTs = userInfo[msg.sender].totalNFTs.sub(1);
        poolInfo.totalNFTs = poolInfo.totalNFTs.sub(1);
        delete positionOwners[tokenId];

        emit Withdraw(msg.sender, tokenId);
    }

    // Calculate rewards for the user based on NFT positions held
    function pendingRewards(address user) public view returns (uint256) {
        UserInfo storage userInfo = userInfo[user];
        uint256 accReward = poolInfo.accRewardPerShare;

        if (poolInfo.totalNFTs > 0) {
            uint256 multiplier = block.number.sub(poolInfo.lastRewardBlock);
            uint256 reward = multiplier.mul(poolInfo.allocPoint);
            accReward = accReward.add(reward.div(poolInfo.totalNFTs));
        }

        return userInfo.totalNFTs.mul(accReward);
    }

    // Harvest pending rewards for the user
    function harvest() external {
        uint256 rewards = pendingRewards(msg.sender);
        require(rewards > 0, "No rewards to harvest");

        // Transfer rewards (Assume rewards are in the form of an ERC20 token)
        // token.safeTransfer(msg.sender, rewards);

        userInfo[msg.sender].totalEarnedRewards = userInfo[msg.sender].totalEarnedRewards.add(rewards);
        userInfo[msg.sender].nextHarvestUntil = block.timestamp.add(1 days);
    }
}
