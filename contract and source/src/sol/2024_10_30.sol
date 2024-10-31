// SPDX-License-Identifier: MIT

// File: contracts/libraries/SafeMath.sol
pragma solidity ^0.8.0;
pragma abicoder v2;


interface IPoolInitializer {
    /// @notice Creates a new pool if it does not exist, then initializes if not initialized
    /// @dev This method can be bundled with others via IMulticall for the first action (e.g. mint) performed against a pool
    /// @param token0 The contract address of token0 of the pool
    /// @param token1 The contract address of token1 of the pool
    /// @param fee The fee amount of the v3 pool for the specified token pair
    /// @param sqrtPriceX96 The initial square root price of the pool as a Q64.96 value
    /// @return pool Returns the pool address based on the pair of tokens and fee, will return the newly created pool address if necessary
    function createAndInitializePoolIfNecessary(
        address token0,
        address token1,
        uint24 fee,
        uint160 sqrtPriceX96
    ) external payable returns (address pool);
}
interface IERC165 {
    /**
     * @dev Returns true if this contract implements the interface defined by
     * `interfaceId`. See the corresponding
     * https://eips.ethereum.org/EIPS/eip-165#how-interfaces-are-identified[ERC section]
     * to learn more about how these ids are created.
     *
     * This function call must use less than 30 000 gas.
     */
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
}

interface IERC721 is IERC165 {
    /**
     * @dev Emitted when `tokenId` token is transferred from `from` to `to`.
     */
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);

    /**
     * @dev Emitted when `owner` enables `approved` to manage the `tokenId` token.
     */
    event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);

    /**
     * @dev Emitted when `owner` enables or disables (`approved`) `operator` to manage all of its assets.
     */
    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);

    /**
     * @dev Returns the number of tokens in ``owner``'s account.
     */
    function balanceOf(address owner) external view returns (uint256 balance);

    /**
     * @dev Returns the owner of the `tokenId` token.
     *
     * Requirements:
     *
     * - `tokenId` must exist.
     */
    function ownerOf(uint256 tokenId) external view returns (address owner);

    /**
     * @dev Safely transfers `tokenId` token from `from` to `to`.
     *
     * Requirements:
     *
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
     * - `tokenId` token must exist and be owned by `from`.
     * - If the caller is not `from`, it must be approved to move this token by either {approve} or {setApprovalForAll}.
     * - If `to` refers to a smart contract, it must implement {IERC721Receiver-onERC721Received}, which is called upon
     *   a safe transfer.
     *
     * Emits a {Transfer} event.
     */
    function safeTransferFrom(address from, address to, uint256 tokenId, bytes calldata data) external;

    /**
     * @dev Safely transfers `tokenId` token from `from` to `to`, checking first that contract recipients
     * are aware of the ERC-721 protocol to prevent tokens from being forever locked.
     *
     * Requirements:
     *
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
     * - `tokenId` token must exist and be owned by `from`.
     * - If the caller is not `from`, it must have been allowed to move this token by either {approve} or
     *   {setApprovalForAll}.
     * - If `to` refers to a smart contract, it must implement {IERC721Receiver-onERC721Received}, which is called upon
     *   a safe transfer.
     *
     * Emits a {Transfer} event.
     */
    function safeTransferFrom(address from, address to, uint256 tokenId) external;

    /**
     * @dev Transfers `tokenId` token from `from` to `to`.
     *
     * WARNING: Note that the caller is responsible to confirm that the recipient is capable of receiving ERC-721
     * or else they may be permanently lost. Usage of {safeTransferFrom} prevents loss, though the caller must
     * understand this adds an external call which potentially creates a reentrancy vulnerability.
     *
     * Requirements:
     *
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
     * - `tokenId` token must be owned by `from`.
     * - If the caller is not `from`, it must be approved to move this token by either {approve} or {setApprovalForAll}.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(address from, address to, uint256 tokenId) external;

    /**
     * @dev Gives permission to `to` to transfer `tokenId` token to another account.
     * The approval is cleared when the token is transferred.
     *
     * Only a single account can be approved at a time, so approving the zero address clears previous approvals.
     *
     * Requirements:
     *
     * - The caller must own the token or be an approved operator.
     * - `tokenId` must exist.
     *
     * Emits an {Approval} event.
     */
    function approve(address to, uint256 tokenId) external;

    /**
     * @dev Approve or remove `operator` as an operator for the caller.
     * Operators can call {transferFrom} or {safeTransferFrom} for any token owned by the caller.
     *
     * Requirements:
     *
     * - The `operator` cannot be the address zero.
     *
     * Emits an {ApprovalForAll} event.
     */
    function setApprovalForAll(address operator, bool approved) external;

    /**
     * @dev Returns the account approved for `tokenId` token.
     *
     * Requirements:
     *
     * - `tokenId` must exist.
     */
    function getApproved(uint256 tokenId) external view returns (address operator);

    /**
     * @dev Returns if the `operator` is allowed to manage all of the assets of `owner`.
     *
     * See {setApprovalForAll}
     */
    function isApprovedForAll(address owner, address operator) external view returns (bool);
}
interface IERC721Enumerable is IERC721 {
    /**
     * @dev Returns the total amount of tokens stored by the contract.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns a token ID owned by `owner` at a given `index` of its token list.
     * Use along with {balanceOf} to enumerate all of ``owner``'s tokens.
     */
    function tokenOfOwnerByIndex(address owner, uint256 index) external view returns (uint256);

    /**
     * @dev Returns a token ID at a given `index` of all the tokens stored by the contract.
     * Use along with {totalSupply} to enumerate all tokens.
     */
    function tokenByIndex(uint256 index) external view returns (uint256);
}
interface IPeripheryImmutableState {
    /// @return Returns the address of the Uniswap V3 factory
    function factory() external view returns (address);

    /// @return Returns the address of WETH9
    function WETH9() external view returns (address);
}

interface IERC721Metadata is IERC721 {
    /**
     * @dev Returns the token collection name.
     */
    function name() external view returns (string memory);

    /**
     * @dev Returns the token collection symbol.
     */
    function symbol() external view returns (string memory);

    /**
     * @dev Returns the Uniform Resource Identifier (URI) for `tokenId` token.
     */
    function tokenURI(uint256 tokenId) external view returns (string memory);
}
interface IPeripheryPayments {
    /// @notice Unwraps the contract's WETH9 balance and sends it to recipient as ETH.
    /// @dev The amountMinimum parameter prevents malicious contracts from stealing WETH9 from users.
    /// @param amountMinimum The minimum amount of WETH9 to unwrap
    /// @param recipient The address receiving ETH
    function unwrapWETH9(uint256 amountMinimum, address recipient) external payable;

    /// @notice Refunds any ETH balance held by this contract to the `msg.sender`
    /// @dev Useful for bundling with mint or increase liquidity that uses ether, or exact output swaps
    /// that use ether for the input amount
    function refundETH() external payable;

    /// @notice Transfers the full amount of a token held by this contract to recipient
    /// @dev The amountMinimum parameter prevents malicious contracts from stealing the token from users
    /// @param token The contract address of the token which will be transferred to `recipient`
    /// @param amountMinimum The minimum amount of token required for a transfer
    /// @param recipient The destination address of the token
    function sweepToken(
        address token,
        uint256 amountMinimum,
        address recipient
    ) external payable;
}
interface IERC721Permit is IERC721 {
    /// @notice The permit typehash used in the permit signature
    /// @return The typehash for the permit
    function PERMIT_TYPEHASH() external pure returns (bytes32);

    /// @notice The domain separator used in the permit signature
    /// @return The domain seperator used in encoding of permit signature
    function DOMAIN_SEPARATOR() external view returns (bytes32);

    /// @notice Approve of a specific token ID for spending by spender via signature
    /// @param spender The account that is being approved
    /// @param tokenId The ID of the token that is being approved for spending
    /// @param deadline The deadline timestamp by which the call must be mined for the approve to work
    /// @param v Must produce valid secp256k1 signature from the holder along with `r` and `s`
    /// @param r Must produce valid secp256k1 signature from the holder along with `v` and `s`
    /// @param s Must produce valid secp256k1 signature from the holder along with `r` and `v`
    function permit(
        address spender,
        uint256 tokenId,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external payable;
}

interface INonfungiblePositionManager is
    IPoolInitializer,
    IPeripheryPayments,
    IPeripheryImmutableState,
    IERC721Metadata,
    IERC721Enumerable,
    IERC721Permit
{
    /// @notice Emitted when liquidity is increased for a position NFT
    /// @dev Also emitted when a token is minted
    /// @param tokenId The ID of the token for which liquidity was increased
    /// @param liquidity The amount by which liquidity for the NFT position was increased
    /// @param amount0 The amount of token0 that was paid for the increase in liquidity
    /// @param amount1 The amount of token1 that was paid for the increase in liquidity
    event IncreaseLiquidity(uint256 indexed tokenId, uint128 liquidity, uint256 amount0, uint256 amount1);
    /// @notice Emitted when liquidity is decreased for a position NFT
    /// @param tokenId The ID of the token for which liquidity was decreased
    /// @param liquidity The amount by which liquidity for the NFT position was decreased
    /// @param amount0 The amount of token0 that was accounted for the decrease in liquidity
    /// @param amount1 The amount of token1 that was accounted for the decrease in liquidity
    event DecreaseLiquidity(uint256 indexed tokenId, uint128 liquidity, uint256 amount0, uint256 amount1);
    /// @notice Emitted when tokens are collected for a position NFT
    /// @dev The amounts reported may not be exactly equivalent to the amounts transferred, due to rounding behavior
    /// @param tokenId The ID of the token for which underlying tokens were collected
    /// @param recipient The address of the account that received the collected tokens
    /// @param amount0 The amount of token0 owed to the position that was collected
    /// @param amount1 The amount of token1 owed to the position that was collected
    event Collect(uint256 indexed tokenId, address recipient, uint256 amount0, uint256 amount1);

    /// @notice Returns the position information associated with a given token ID.
    /// @dev Throws if the token ID is not valid.
    /// @param tokenId The ID of the token that represents the position
    /// @return nonce The nonce for permits
    /// @return operator The address that is approved for spending
    /// @return token0 The address of the token0 for a specific pool
    /// @return token1 The address of the token1 for a specific pool
    /// @return fee The fee associated with the pool
    /// @return tickLower The lower end of the tick range for the position
    /// @return tickUpper The higher end of the tick range for the position
    /// @return liquidity The liquidity of the position
    /// @return feeGrowthInside0LastX128 The fee growth of token0 as of the last action on the individual position
    /// @return feeGrowthInside1LastX128 The fee growth of token1 as of the last action on the individual position
    /// @return tokensOwed0 The uncollected amount of token0 owed to the position as of the last computation
    /// @return tokensOwed1 The uncollected amount of token1 owed to the position as of the last computation
    function positions(uint256 tokenId)
        external
        view
        returns (
            uint96 nonce,
            address operator,
            address token0,
            address token1,
            uint24 fee,
            int24 tickLower,
            int24 tickUpper,
            uint128 liquidity,
            uint256 feeGrowthInside0LastX128,
            uint256 feeGrowthInside1LastX128,
            uint128 tokensOwed0,
            uint128 tokensOwed1
        );

    struct MintParams {
        address token0;
        address token1;
        uint24 fee;
        int24 tickLower;
        int24 tickUpper;
        uint256 amount0Desired;
        uint256 amount1Desired;
        uint256 amount0Min;
        uint256 amount1Min;
        address recipient;
        uint256 deadline;
    }

    /// @notice Creates a new position wrapped in a NFT
    /// @dev Call this when the pool does exist and is initialized. Note that if the pool is created but not initialized
    /// a method does not exist, i.e. the pool is assumed to be initialized.
    /// @param params The params necessary to mint a position, encoded as `MintParams` in calldata
    /// @return tokenId The ID of the token that represents the minted position
    /// @return liquidity The amount of liquidity for this position
    /// @return amount0 The amount of token0
    /// @return amount1 The amount of token1
    function mint(MintParams calldata params)
        external
        payable
        returns (
            uint256 tokenId,
            uint128 liquidity,
            uint256 amount0,
            uint256 amount1
        );

    struct IncreaseLiquidityParams {
        uint256 tokenId;
        uint256 amount0Desired;
        uint256 amount1Desired;
        uint256 amount0Min;
        uint256 amount1Min;
        uint256 deadline;
    }

    /// @notice Increases the amount of liquidity in a position, with tokens paid by the `msg.sender`
    /// @param params tokenId The ID of the token for which liquidity is being increased,
    /// amount0Desired The desired amount of token0 to be spent,
    /// amount1Desired The desired amount of token1 to be spent,
    /// amount0Min The minimum amount of token0 to spend, which serves as a slippage check,
    /// amount1Min The minimum amount of token1 to spend, which serves as a slippage check,
    /// deadline The time by which the transaction must be included to effect the change
    /// @return liquidity The new liquidity amount as a result of the increase
    /// @return amount0 The amount of token0 to acheive resulting liquidity
    /// @return amount1 The amount of token1 to acheive resulting liquidity
    function increaseLiquidity(IncreaseLiquidityParams calldata params)
        external
        payable
        returns (
            uint128 liquidity,
            uint256 amount0,
            uint256 amount1
        );

    struct DecreaseLiquidityParams {
        uint256 tokenId;
        uint128 liquidity;
        uint256 amount0Min;
        uint256 amount1Min;
        uint256 deadline;
    }

    /// @notice Decreases the amount of liquidity in a position and accounts it to the position
    /// @param params tokenId The ID of the token for which liquidity is being decreased,
    /// amount The amount by which liquidity will be decreased,
    /// amount0Min The minimum amount of token0 that should be accounted for the burned liquidity,
    /// amount1Min The minimum amount of token1 that should be accounted for the burned liquidity,
    /// deadline The time by which the transaction must be included to effect the change
    /// @return amount0 The amount of token0 accounted to the position's tokens owed
    /// @return amount1 The amount of token1 accounted to the position's tokens owed
    function decreaseLiquidity(DecreaseLiquidityParams calldata params)
        external
        payable
        returns (uint256 amount0, uint256 amount1);

    struct CollectParams {
        uint256 tokenId;
        address recipient;
        uint128 amount0Max;
        uint128 amount1Max;
    }

    /// @notice Collects up to a maximum amount of fees owed to a specific position to the recipient
    /// @param params tokenId The ID of the NFT for which tokens are being collected,
    /// recipient The account that should receive the tokens,
    /// amount0Max The maximum amount of token0 to collect,
    /// amount1Max The maximum amount of token1 to collect
    /// @return amount0 The amount of fees collected in token0
    /// @return amount1 The amount of fees collected in token1
    function collect(CollectParams calldata params) external payable returns (uint256 amount0, uint256 amount1);

    /// @notice Burns a token ID, which deletes it from the NFT contract. The token must have 0 liquidity and all tokens
    /// must be collected first.
    /// @param tokenId The ID of the token that is being burned
    function burn(uint256 tokenId) external payable;
}

interface IUniswapV3SwapCallback {
    /// @notice Called to `msg.sender` after executing a swap via IUniswapV3Pool#swap.
    /// @dev In the implementation you must pay the pool tokens owed for the swap.
    /// The caller of this method must be checked to be a UniswapV3Pool deployed by the canonical UniswapV3Factory.
    /// amount0Delta and amount1Delta can both be 0 if no tokens were swapped.
    /// @param amount0Delta The amount of token0 that was sent (negative) or must be received (positive) by the pool by
    /// the end of the swap. If positive, the callback must send that amount of token0 to the pool.
    /// @param amount1Delta The amount of token1 that was sent (negative) or must be received (positive) by the pool by
    /// the end of the swap. If positive, the callback must send that amount of token1 to the pool.
    /// @param data Any data passed through by the caller via the IUniswapV3PoolActions#swap call
    function uniswapV3SwapCallback(
        int256 amount0Delta,
        int256 amount1Delta,
        bytes calldata data
    ) external;
}

/// @title Router token swapping functionality
/// @notice Functions for swapping tokens via Uniswap V3
interface ISwapRouter is IUniswapV3SwapCallback {
    struct ExactInputSingleParams {
        address tokenIn;
        address tokenOut;
        uint24 fee;
        address recipient;
        uint256 deadline;
        uint256 amountIn;
        uint256 amountOutMinimum;
        uint160 sqrtPriceLimitX96;
    }

    /// @notice Swaps `amountIn` of one token for as much as possible of another token
    /// @param params The parameters necessary for the swap, encoded as `ExactInputSingleParams` in calldata
    /// @return amountOut The amount of the received token
    function exactInputSingle(ExactInputSingleParams calldata params) external payable returns (uint256 amountOut);

    struct ExactInputParams {
        bytes path;
        address recipient;
        uint256 deadline;
        uint256 amountIn;
        uint256 amountOutMinimum;
    }

    /// @notice Swaps `amountIn` of one token for as much as possible of another along the specified path
    /// @param params The parameters necessary for the multi-hop swap, encoded as `ExactInputParams` in calldata
    /// @return amountOut The amount of the received token
    function exactInput(ExactInputParams calldata params) external payable returns (uint256 amountOut);

    struct ExactOutputSingleParams {
        address tokenIn;
        address tokenOut;
        uint24 fee;
        address recipient;
        uint256 deadline;
        uint256 amountOut;
        uint256 amountInMaximum;
        uint160 sqrtPriceLimitX96;
    }

    /// @notice Swaps as little as possible of one token for `amountOut` of another token
    /// @param params The parameters necessary for the swap, encoded as `ExactOutputSingleParams` in calldata
    /// @return amountIn The amount of the input token
    function exactOutputSingle(ExactOutputSingleParams calldata params) external payable returns (uint256 amountIn);

    struct ExactOutputParams {
        bytes path;
        address recipient;
        uint256 deadline;
        uint256 amountOut;
        uint256 amountInMaximum;
    }

    /// @notice Swaps as little as possible of one token for `amountOut` of another along the specified path (reversed)
    /// @param params The parameters necessary for the multi-hop swap, encoded as `ExactOutputParams` in calldata
    /// @return amountIn The amount of the input token
    function exactOutput(ExactOutputParams calldata params) external payable returns (uint256 amountIn);
}


pragma solidity ^0.8.20;

/**
 * @title ERC-721 token receiver interface
 * @dev Interface for any contract that wants to support safeTransfers
 * from ERC-721 asset contracts.
 */
interface IERC721Receiver {
    /**
     * @dev Whenever an {IERC721} `tokenId` token is transferred to this contract via {IERC721-safeTransferFrom}
     * by `operator` from `from`, this function is called.
     *
     * It must return its Solidity selector to confirm the token transfer.
     * If any other value is returned or the interface is not implemented by the recipient, the transfer will be
     * reverted.
     *
     * The selector can be obtained in Solidity with `IERC721Receiver.onERC721Received.selector`.
     */
    function onERC721Received(
        address operator,
        address from,
        uint256 tokenId,
        bytes calldata data
    ) external returns (bytes4);
}


library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function tryAdd(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        uint256 c = a + b;
        if (c < a) return (false, 0);
        return (true, c);
    }

    /**
     * @dev Returns the substraction of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function trySub(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        if (b > a) return (false, 0);
        return (true, a - b);
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function tryMul(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
        if (a == 0) return (true, 0);
        uint256 c = a * b;
        if (c / a != b) return (false, 0);
        return (true, c);
    }

    /**
     * @dev Returns the division of two unsigned integers, with a division by zero flag.
     *
     * _Available since v3.4._
     */
    function tryDiv(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        if (b == 0) return (false, 0);
        return (true, a / b);
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers, with a division by zero flag.
     *
     * _Available since v3.4._
     */
    function tryMod(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        if (b == 0) return (false, 0);
        return (true, a % b);
    }

    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     *
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");
        return c;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a, "SafeMath: subtraction overflow");
        return a - b;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     *
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) return 0;
        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");
        return c;
    }

    /**
     * @dev Returns the integer division of two unsigned integers, reverting on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b > 0, "SafeMath: division by zero");
        return a / b;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * reverting when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b > 0, "SafeMath: modulo by zero");
        return a % b;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {trySub}.
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        return a - b;
    }

    /**
     * @dev Returns the integer division of two unsigned integers, reverting with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {tryDiv}.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b > 0, errorMessage);
        return a / b;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * reverting with custom message when dividing by zero.
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {tryMod}.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b > 0, errorMessage);
        return a % b;
    }
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

    /**
     * @dev Replacement for Solidity's `transfer`: sends `amount` wei to
     * `recipient`, forwarding all available gas and reverting on errors.
     *
     * https://eips.ethereum.org/EIPS/eip-1884[EIP1884] increases the gas cost
     * of certain opcodes, possibly making contracts go over the 2300 gas limit
     * imposed by `transfer`, making them unable to receive funds via
     * `transfer`. {sendValue} removes this limitation.
     *
     * https://diligence.consensys.net/posts/2019/09/stop-using-soliditys-transfer-now/[Learn more].
     *
     * IMPORTANT: because control is transferred to `recipient`, care must be
     * taken to not create reentrancy vulnerabilities. Consider using
     * {ReentrancyGuard} or the
     * https://solidity.readthedocs.io/en/v0.5.11/security-considerations.html#use-the-checks-effects-interactions-pattern[checks-effects-interactions pattern].
     */
    function sendValue(address payable recipient, uint256 amount) internal {
        require(address(this).balance >= amount, "Address: insufficient balance");

        // solhint-disable-next-line avoid-low-level-calls, avoid-call-value
        (bool success, ) = recipient.call{ value: amount }("");
        require(success, "Address: unable to send value, recipient may have reverted");
    }

    /**
     * @dev Performs a Solidity function call using a low level `call`. A
     * plain`call` is an unsafe replacement for a function call: use this
     * function instead.
     *
     * If `target` reverts with a revert reason, it is bubbled up by this
     * function (like regular Solidity function calls).
     *
     * Returns the raw returned data. To convert to the expected return value,
     * use https://solidity.readthedocs.io/en/latest/units-and-global-variables.html?highlight=abi.decode#abi-encoding-and-decoding-functions[`abi.decode`].
     *
     * Requirements:
     *
     * - `target` must be a contract.
     * - calling `target` with `data` must not revert.
     *
     * _Available since v3.1._
     */
    function functionCall(address target, bytes memory data) internal returns (bytes memory) {
      return functionCall(target, data, "Address: low-level call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`], but with
     * `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCall(address target, bytes memory data, string memory errorMessage) internal returns (bytes memory) {
        return functionCallWithValue(target, data, 0, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but also transferring `value` wei to `target`.
     *
     * Requirements:
     *
     * - the calling contract must have an FTM balance of at least `value`.
     * - the called Solidity function must be `payable`.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(address target, bytes memory data, uint256 value) internal returns (bytes memory) {
        return functionCallWithValue(target, data, value, "Address: low-level call with value failed");
    }

    /**
     * @dev Same as {xref-Address-functionCallWithValue-address-bytes-uint256-}[`functionCallWithValue`], but
     * with `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(address target, bytes memory data, uint256 value, string memory errorMessage) internal returns (bytes memory) {
        require(address(this).balance >= value, "Address: insufficient balance for call");
        require(isContract(target), "Address: call to non-contract");

        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory returndata) = target.call{ value: value }(data);
        return _verifyCallResult(success, returndata, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but performing a static call.
     *
     * _Available since v3.3._
     */
    function functionStaticCall(address target, bytes memory data) internal view returns (bytes memory) {
        return functionStaticCall(target, data, "Address: low-level static call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
     * but performing a static call.
     *
     * _Available since v3.3._
     */
    function functionStaticCall(address target, bytes memory data, string memory errorMessage) internal view returns (bytes memory) {
        require(isContract(target), "Address: static call to non-contract");

        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory returndata) = target.staticcall(data);
        return _verifyCallResult(success, returndata, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but performing a delegate call.
     *
     * _Available since v3.4._
     */
    function functionDelegateCall(address target, bytes memory data) internal returns (bytes memory) {
        return functionDelegateCall(target, data, "Address: low-level delegate call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
     * but performing a delegate call.
     *
     * _Available since v3.4._
     */
    function functionDelegateCall(address target, bytes memory data, string memory errorMessage) internal returns (bytes memory) {
        require(isContract(target), "Address: delegate call to non-contract");

        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory returndata) = target.delegatecall(data);
        return _verifyCallResult(success, returndata, errorMessage);
    }

    function _verifyCallResult(bool success, bytes memory returndata, string memory errorMessage) private pure returns(bytes memory) {
        if (success) {
            return returndata;
        } else {
            // Look for revert reason and bubble it up if present
            if (returndata.length > 0) {
                // The easiest way to bubble the revert reason is using memory via assembly

                // solhint-disable-next-line no-inline-assembly
                assembly {
                    let returndata_size := mload(returndata)
                    revert(add(32, returndata), returndata_size)
                }
            } else {
                revert(errorMessage);
            }
        }
    }
}

library SafeERC20 {
    using Address for address;

    function safeTransfer(
        IERC20 token,
        address to,
        uint256 value
    ) internal {
        _callOptionalReturn(token, abi.encodeWithSelector(token.transfer.selector, to, value));
    }

    function safeTransferFrom(
        IERC20 token,
        address from,
        address to,
        uint256 value
    ) internal {
        _callOptionalReturn(token, abi.encodeWithSelector(token.transferFrom.selector, from, to, value));
    }

    /**
     * @dev Deprecated. This function has issues similar to the ones found in
     * {IERC20-approve}, and its usage is discouraged.
     *
     * Whenever possible, use {safeIncreaseAllowance} and
     * {safeDecreaseAllowance} instead.
     */
    function safeApprove(
        IERC20 token,
        address spender,
        uint256 value
    ) internal {
        // safeApprove should only be called when setting an initial allowance,
        // or when resetting it to zero. To increase and decrease it, use
        // 'safeIncreaseAllowance' and 'safeDecreaseAllowance'
        require(
            (value == 0) || (token.allowance(address(this), spender) == 0),
            "SafeERC20: approve from non-zero to non-zero allowance"
        );
        _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, value));
    }

    function safeIncreaseAllowance(
        IERC20 token,
        address spender,
        uint256 value
    ) internal {
        uint256 newAllowance = token.allowance(address(this), spender) + value;
        _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));
    }

    function safeDecreaseAllowance(
        IERC20 token,
        address spender,
        uint256 value
    ) internal {
        unchecked {
            uint256 oldAllowance = token.allowance(address(this), spender);
            require(oldAllowance >= value, "SafeERC20: decreased allowance below zero");
            uint256 newAllowance = oldAllowance - value;
            _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));
        }
    }

    /**
     * @dev Imitates a Solidity high-level call (i.e. a regular function call to a contract), relaxing the requirement
     * on the return value: the return value is optional (but if data is returned, it must not be false).
     * @param token The token targeted by the call.
     * @param data The call data (encoded using abi.encode or one of its variants).
     */
    function _callOptionalReturn(IERC20 token, bytes memory data) private {
        // We need to perform a low level call here, to bypass Solidity's return data size checking mechanism, since
        // we're implementing it ourselves. We use {Address.functionCall} to perform this call, which verifies that
        // the target address contains contract code and also asserts for success in the low-level call.

        bytes memory returndata = address(token).functionCall(data, "SafeERC20: low-level call failed");
        if (returndata.length > 0) {
            // Return data is optional
            require(abi.decode(returndata, (bool)), "SafeERC20: ERC20 operation did not succeed");
        }
    }
}
interface IERC20 {
    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `recipient`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a `Transfer` event.
     */
    function transfer(address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through `transferFrom`. This is
     * zero by default.
     *
     * This value changes when `approve` or `transferFrom` are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * > Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an `Approval` event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `sender` to `recipient` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a `Transfer` event.
     */
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to `approve`. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);
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

    INonfungiblePositionManager public positionManager;
    // Info of each user.
    struct UserInfo {
        uint256 amount;             // How many LP tokens the user has provided.
        uint256 nextHarvestUntil;   // When can the user harvest again.
        uint256 totalEarnedDiamond;
        uint256 taxAmount;
    }

    // Info of each pool.
    struct PoolInfo {
        INonfungiblePositionManager positionManager;           // Position of LP NFT contract.
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
    mapping(uint256 => address) public positionOwners; 

    // Total allocation points. Must be the sum of all allocation points in all pools.
    uint256 public totalAllocPoint = 0;

    mapping(uint256 => bool) public enableStaking;
    
    event Deposit(address indexed user, uint256 indexed pid, uint256 amount);
    event Withdraw(address indexed user, uint256 indexed pid, uint256 amount);
    event EmergencyWithdraw(address indexed user, uint256 indexed pid, uint256 amount);

    constructor (address _diamond) {      
        diamond = _diamond;
    }

    receive() external payable {
    }

    function setEnableStaking(uint256 _pid, bool _bEnable) external onlyOwner {
        enableStaking[_pid] = _bEnable;
    }
    
    function poolLength() external view returns (uint256) {
        return poolInfo.length;
    }

    // Add a new lp to the pool. Can only be called by the owner.
    // XXX DO NOT add the same LP token more than once. Rewards will be messed up if you do.
    // function add(uint256 _allocPoint, INonfungiblePositionManager _positionManager, uint16 _depositFeeBP, bool _withUpdate) public onlyOwner {
    //     require(_depositFeeBP <= 10000, "add: invalid deposit fee basis points");
    //     if (_withUpdate) {
    //         massUpdatePools();
    //     }
    //     uint256 lastRewardBlock = block.number;
    //     totalAllocPoint = totalAllocPoint.add(_allocPoint);
    //     poolInfo.push(PoolInfo({
    //         positionManager: _positionManager,
    //         allocPoint: _allocPoint,
    //         lastRewardBlock: lastRewardBlock,
    //         accDiamondPerShare: 0,
    //         harvestInterval: DEFAULT_HARVEST_INTERVAL,
    //         totalAmountFromFeeByRewards: 0
    //     }));
    // }

    // Update the given pool's Diamond allocation point and deposit fee. Can only be called by the owner.
    // function set(uint8 _pid, uint256 _allocPoint, uint16 _depositFeeBP, bool _withUpdate) public onlyOwner {
    //     require(_depositFeeBP <= 10000, "set: invalid deposit fee basis points");
        
    //     if (_withUpdate) {
    //         massUpdatePools();
    //     }

    //     totalAllocPoint = totalAllocPoint.sub(poolInfo[_pid].allocPoint).add(_allocPoint);
    //     poolInfo[_pid].allocPoint = _allocPoint;
    //     poolInfo[_pid].harvestInterval = DEFAULT_HARVEST_INTERVAL;
    // }

    // function addRewards(uint256 _amount, uint256 _days) public onlyOwner {
    //     require(_amount <= IERC20(diamond).balanceOf(msg.sender), 'Deposite: Insufficient Balance of Diamond');

    //     uint256 period = _days.mul(1 days);
    //     require(block.timestamp >= nextAddDiamond, "Too early to add Diamond.");

    //     IERC20(diamond).safeTransferFrom(address(msg.sender), address(this), _amount);

    //     diamondPerBlock = _amount.div(period);
    //     nextAddDiamond = block.timestamp + period;
    //     totalDiamondRewards = totalDiamondRewards.add(_amount);

    //     addRewardInfo.push(RewardInfo({
    //         startBlockNumber: block.number,
    //         endBlockNumber: block.number + period,
    //         rewardAmount: _amount
    //     }));
    // }

    // Return reward multiplier over the given _from to _to block.
    // function getMultiplier(uint256 _from, uint256 _to) public pure returns (uint256) {
    //     return _to.sub(_from);
    // }
    
    // Return total reward multiplier over the given _from to _to block.
    function getTotalDiamondReward() public view returns (uint256) {   
        return totalDiamondRewards;
    }

    function deposit(uint256 _pid, uint256 _amount) public nonReentrant {
        require(enableStaking[_pid] == true, 'Deposite: DISABLE DEPOSITING');
        require(_amount > 0, 'Deposite: DISABLE DEPOSITING');
        
        PoolInfo storage pool = poolInfo[_pid];
        UserInfo storage user = userInfo[_pid][msg.sender];

        updatePool(_pid);

        pool.positionManager.safeTransferFrom(address(msg.sender), address(this), _pid);
        
        user.amount = user.amount.add(_amount);

        depositInfo[msg.sender][_pid].push(DepositInfo({
            pid: _pid,
            amount: _amount,
            lockupPeriod:MAX_HARVEST_INTERVAL,
            nextWithdraw: block.timestamp.add(MAX_HARVEST_INTERVAL),
            accDiamondPerShare: pool.accDiamondPerShare,
            taxAmount: 0
        }));
        totalAllocPoint = totalAllocPoint.add(1);
        // if (user.nextHarvestUntil == 0) {
        //     user.nextHarvestUntil = block.timestamp.add(MAX_HARVEST_INTERVAL);
        // }

        emit Deposit(msg.sender, _pid, _amount);
    }

    function withdraw(uint258 _pid) public nonReentrant {
        require(enableStaking[_pid] == true, 'Withdraw: DISABLE WITHDRAWING');
        
        PoolInfo storage pool = poolInfo[_pid];
        UserInfo storage user = userInfo[_pid][msg.sender];
        // require(user.amount >= _amount, "withdraw: not good");

        // uint256 availableAmount = availableForWithdraw(msg.sender, _pid);
        // require(availableAmount > 0, "withdraw: no available amount");

        // if (availableAmount < _amount) {
        //     _amount = availableAmount;
        // }

        // updatePool(_pid);
        // if (_amount > 0) {
        //     user.amount = user.amount.sub(_amount);
        pool.positionManager.safeTransfer(address(this), msg.sender, _pid);
        // payOrLockupPendingDiamond(_pid, -1);
        depositInfo[_user][_pid].length = depositInfo[_user][_pid].length.sub(1);
        depositInfo[user][_pid].pop();
        // }

        // Remove desosit info in the array
        // removeAmountFromDeposits(msg.sender, _pid, _amount, block.timestamp);
        // removeEmptyDeposits(msg.sender, _pid);

        totalAllocPoint = totalAllocPoint.sub(1);
        emit Withdraw(msg.sender, _pid, _amount);
    }

    
    // Withdraw without caring about rewards. EMERGENCY ONLY.
    function emergencyWithdraw(uint256 _pid) public nonReentrant {
        require(enableStaking[_pid] == true, 'Withdraw: DISABLE WITHDRAWING');
        
        PoolInfo storage pool = poolInfo[_pid];
        UserInfo storage user = userInfo[_pid][msg.sender];
        uint256 amount = user.amount;
        user.amount = 0;
        user.nextHarvestUntil = 0;
        pool.positionManager.safeTransfer(address(this), msg.sender, _pid);
        emit EmergencyWithdraw(msg.sender, _pid, amount);
    }

    // Harvest rewards.
    function harvest(uint256 _pid) public nonReentrant {
        require(enableStaking[_pid] == true, 'Deposite: DISABLE DEPOSITING');

        updatePool(_pid);
        payOrLockupPendingDiamond(_pid, -1);
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

    // Return reward multiplier over the given _from to _to block.
    function getDiamondRewardFromBlock(uint256 _pid) public view returns (uint256) {
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

    // fixing pending
    function pendingDiamondForDeposit(uint8 _pid, address _user, int256 _depositIndex) 
        public view returns (uint256 totalPending, uint256 claimablePending) {
        PoolInfo storage pool = poolInfo[_pid];
        
        uint256 lpSupply = pool.positionManager.getLiquidityByOwner(address(this));

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
    // function deposit(uint8 _pid, uint256 _amount) public nonReentrant {
    //     require(enableStaking[_pid] == true, 'Deposite: DISABLE DEPOSITING');
    //     require(_amount > 0, 'Deposite: DISABLE DEPOSITING');
        
    //     PoolInfo storage pool = poolInfo[_pid];
    //     UserInfo storage user = userInfo[_pid][msg.sender];

    //     updatePool(_pid);

    //     pool.lpToken.safeTransferFrom(address(msg.sender), address(this), _amount);
    //     user.amount = user.amount.add(_amount);

    //     depositInfo[msg.sender][_pid].push(DepositInfo({
    //         pid: _pid,
    //         amount: _amount,
    //         lockupPeriod:MAX_HARVEST_INTERVAL,
    //         nextWithdraw: block.timestamp.add(MAX_HARVEST_INTERVAL),
    //         accDiamondPerShare: pool.accDiamondPerShare,
    //         taxAmount: 0
    //     }));

    //     if (user.nextHarvestUntil == 0) {
    //         user.nextHarvestUntil = block.timestamp.add(MAX_HARVEST_INTERVAL);
    //     }

    //     emit Deposit(msg.sender, _pid, _amount);
    // }

    // function deposit(uint256 tokenId) external nonReentrant {
    //     require(enableStaking[tokenId] == true, 'Deposit: DISABLE DEPOSITING');

    //     // Transfer NFT to this contract
    //     positionManager.safeTransferFrom(msg.sender, address(this), tokenId);

    //     // Record the owner of the NFT
    //     positionOwners[tokenId] = msg.sender;

    //     emit Deposit(msg.sender, tokenId, 1);  // TokenId represents the deposit
    // }

    function onERC721Received(
        // address operator,
        // address from,
        // uint256 tokenId,
        // bytes calldata data
    ) external pure returns (bytes4) {
        return this.onERC721Received.selector;
    }
    // Harvest rewards.
    // function harvest(uint8 _pid) public nonReentrant {
    //     require(enableStaking[_pid] == true, 'Deposite: DISABLE DEPOSITING');

    //     updatePool(_pid);
    //     payOrLockupPendingDiamond(_pid, -1);
    // }
    function harvest(uint256 tokenId) external nonReentrant {
        require(positionOwners[tokenId] == msg.sender, 'Harvest: NOT OWNER');
        
        uint256 reward = calculateRewardRate(tokenId, msg.sender, 0);

        // Transfer the reward tokens to the user
        safeDiamondTransfer(msg.sender, reward);

        // emit Harvest(msg.sender, tokenId, reward);
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

    // function calculateRewardRate(uint8 _pid, address _user, uint256 _depositIndex) 
    //         public view returns (uint256 rewardRate) {
    //     DepositInfo storage myDeposit =  depositInfo[_user][_pid][_depositIndex];

    //     if (block.timestamp < myDeposit.nextWithdraw)
    //         return lockUpTaxRate;

    //     uint256 elapsedTime = block.timestamp.sub(myDeposit.nextWithdraw);

    //     uint256 interval = elapsedTime.div(MAX_HARVEST_INTERVAL);

    //     if (lockUpTaxRate > (interval.add(1)).mul(100))
    //         rewardRate = lockUpTaxRate.sub((interval.add(1)).mul(100));
    //     else 
    //         rewardRate = 0;
    // }
    function getLiquidity(uint256 tokenId) public view returns (uint128 liquidity) {
        (, , , , , , , liquidity, , , , ) = positionManager.positions(tokenId);
        return liquidity;
    }

    function calculateRewardRate(uint256 tokenId, address user, uint256 _depositIndex) public view returns (uint256 reward) {
        uint128 liquidity = getLiquidity(tokenId);
        // Calculate rewards based on liquidity
        require(user == positionOwners[tokenId], 'Not user');
        reward = liquidity * diamondPerBlock / _depositIndex;  // Adjust as needed
        return reward;
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
    // function withdraw(uint8 _pid, uint256 _amount) public nonReentrant {
    //     require(enableStaking[_pid] == true, 'Withdraw: DISABLE WITHDRAWING');
        
    //     PoolInfo storage pool = poolInfo[_pid];
    //     UserInfo storage user = userInfo[_pid][msg.sender];

    //     require(user.amount >= _amount, "withdraw: not good");

    //     uint256 availableAmount = availableForWithdraw(msg.sender, _pid);
    //     require(availableAmount > 0, "withdraw: no available amount");

    //     if (availableAmount < _amount) {
    //         _amount = availableAmount;
    //     }

    //     updatePool(_pid);
    //     payOrLockupPendingDiamond(_pid, -1);

    //     if (_amount > 0) {
    //         user.amount = user.amount.sub(_amount);
    //         pool.lpToken.safeTransfer(address(msg.sender), _amount);
    //     }

    //     // Remove desosit info in the array
    //     removeAmountFromDeposits(msg.sender, _pid, _amount, block.timestamp);
    //     removeEmptyDeposits(msg.sender, _pid);
        
    //     emit Withdraw(msg.sender, _pid, _amount);
    // }
    // function withdraw(uint256 tokenId) external nonReentrant {
    //     require(positionOwners[tokenId] == msg.sender, 'Withdraw: NOT OWNER');

    //     // Transfer the NFT back to the user
    //     positionManager.safeTransferFrom(address(this), msg.sender, tokenId);

    //     // Clear the owner record
    //     delete positionOwners[tokenId];

    //     emit Withdraw(msg.sender, tokenId, 1);
    // }


    // Pay or lockup pending BloqBalls.
    // function payOrLockupPendingDiamond(uint8 _pid, int256 _depositIndex) public {
    //     require(enableStaking[_pid] == true, 'Withdraw: DISABLE WITHDRAWING');
        
    //     PoolInfo storage pool = poolInfo[_pid];
    //     UserInfo storage user = userInfo[_pid][msg.sender];

    //     uint256 claimablePending;
    //     uint256 taxPending;

    //     if (_depositIndex >= 0) {
    //         (, uint256 _claimablePending, uint256 _taxPending) = 
    //             availableIndividualRewardsForHarvest(_pid, msg.sender, pool.accDiamondPerShare, uint256(_depositIndex));

    //         claimablePending = _claimablePending;
    //         taxPending = _taxPending;
    //     }
    //     else {
    //         (, uint256 _claimablePending, uint256 _taxPending) = 
    //             availableRewardsForHarvest(_pid, msg.sender, pool.accDiamondPerShare);

    //         claimablePending = _claimablePending;
    //         taxPending = _taxPending;        
    //     }

    //     if (canHarvest(_pid, msg.sender)) {
    //         if (claimablePending > 0) {
    //             pool.totalAmountFromFeeByRewards = pool.totalAmountFromFeeByRewards.add(taxPending);
    //             user.nextHarvestUntil = block.timestamp.add(pool.harvestInterval);

    //             // send Diamond rewards
    //             safeDiamondTransfer(msg.sender, claimablePending);

    //             user.totalEarnedDiamond = user.totalEarnedDiamond.add(claimablePending);
    //             user.taxAmount = taxPending;

    //             updateDepositInfo(_pid, msg.sender, _depositIndex);
    //         }
    //     }
    // }
    
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

    // function removeEmptyDeposits(address user, uint8 _pid) public {
    //     for (uint256 i=0; i<depositInfo[user][_pid].length; i++) {
    //         while(depositInfo[user][_pid].length > 0 && depositInfo[user][_pid][i].amount  == 0) {
    //             for (uint256 j = i; j<depositInfo[user][_pid].length-1; j++) {
    //                 depositInfo[user][_pid][j] = depositInfo[user][_pid][j+1];
    //             }
    //             depositInfo[user][_pid].pop();
    //         }
    //     }
    // }
}