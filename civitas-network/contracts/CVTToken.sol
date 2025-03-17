// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

/**
 * @title Civitas Token (CVT)
 * @dev ERC-20 token with staking, governance, minting, and vesting capabilities.
 */
contract CVTToken is ERC20, Ownable, ReentrancyGuard {
    uint256 public constant INITIAL_SUPPLY = 1_000_000_000 * 10**18; // 1 Billion Tokens
    uint256 public totalStaked;

    mapping(address => uint256) private _stakes;
    mapping(address => uint256) private _stakeTimestamps;
    mapping(address => uint256) private _vestingBalances;
    mapping(address => uint256) private _vestingStart;

    event Staked(address indexed user, uint256 amount, uint256 timestamp);
    event Unstaked(address indexed user, uint256 amount, uint256 reward);
    event Minted(address indexed to, uint256 amount);
    event TokensVested(address indexed beneficiary, uint256 amount, uint256 releaseTime);
    event TokensReleased(address indexed beneficiary, uint256 amount);

    /**
     * @dev Constructor that mints initial supply to the deployer.
     */
    constructor() ERC20("Civitas Token", "CVT") {
        _mint(msg.sender, INITIAL_SUPPLY);
    }
    
    /**
     * @dev Mint function (restricted to owner/governance contract in the future).
     * @param to The recipient address.
     * @param amount The amount to be minted.
     */
    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
        emit Minted(to, amount);
    }

    /**
     * @dev Stake tokens to earn rewards.
     * @param amount The amount of tokens to stake.
     */
    function stake(uint256 amount) external nonReentrant {
        require(amount > 0, "Cannot stake zero tokens");
        require(balanceOf(msg.sender) >= amount, "Insufficient balance");
        
        _transfer(msg.sender, address(this), amount);
        _stakes[msg.sender] += amount;
        _stakeTimestamps[msg.sender] = block.timestamp;
        totalStaked += amount;
        
        emit Staked(msg.sender, amount, block.timestamp);
    }

    /**
     * @dev Unstake tokens and receive rewards.
     */
    function unstake() external nonReentrant {
        require(_stakes[msg.sender] > 0, "No tokens staked");
        
        uint256 stakedAmount = _stakes[msg.sender];
        uint256 stakingDuration = block.timestamp - _stakeTimestamps[msg.sender];
        uint256 reward = calculateReward(stakedAmount, stakingDuration);
        
        _stakes[msg.sender] = 0;
        totalStaked -= stakedAmount;
        
        _mint(msg.sender, reward);
        _transfer(address(this), msg.sender, stakedAmount);
        
        emit Unstaked(msg.sender, stakedAmount, reward);
    }

    /**
     * @dev Calculate staking rewards based on duration and amount.
     * @param amount Staked amount.
     * @param duration Staking duration in seconds.
     * @return Reward amount.
     */
    function calculateReward(uint256 amount, uint256 duration) public pure returns (uint256) {
        uint256 baseRate = 10; // Base APY of 10%
        uint256 reward = (amount * baseRate * duration) / (365 days * 100);
        return reward;
    }

    /**
     * @dev Assigns vesting schedule to an address.
     * @param beneficiary The address receiving vested tokens.
     * @param amount The amount of tokens to vest.
     * @param releaseTime The time (timestamp) when tokens can be claimed.
     */
    function vestTokens(address beneficiary, uint256 amount, uint256 releaseTime) external onlyOwner {
        require(releaseTime > block.timestamp, "Release time must be in the future");
        require(balanceOf(owner()) >= amount, "Insufficient balance for vesting");
        
        _transfer(owner(), address(this), amount);
        _vestingBalances[beneficiary] += amount;
        _vestingStart[beneficiary] = releaseTime;
        
        emit TokensVested(beneficiary, amount, releaseTime);
    }

    /**
     * @dev Claim vested tokens after the release time has passed.
     */
    function claimVestedTokens() external nonReentrant {
        require(_vestingBalances[msg.sender] > 0, "No vested tokens available");
        require(block.timestamp >= _vestingStart[msg.sender], "Tokens are still vested");
        
        uint256 amount = _vestingBalances[msg.sender];
        _vestingBalances[msg.sender] = 0;
        
        _transfer(address(this), msg.sender, amount);
        emit TokensReleased(msg.sender, amount);
    }
}
