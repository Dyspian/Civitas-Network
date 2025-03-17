# Advanced Token Distribution Model

## Overview

The **Civitas Network** introduces an **Advanced Token Distribution Model** designed to ensure fair allocation, long-term sustainability, and incentivized participation. This model incorporates virtual mining, staking rewards, and team vesting schedules to create an equitable token economy.

## 📊 Total Supply & Allocation Breakdown

**Total Token Supply:** 1,000,000,000 CVT (Civitas Tokens)

| Category                         | % of Total Supply | Tokens Allocated | Description                                                           |
|----------------------------------|-------------------|------------------|-----------------------------------------------------------------------|
| 🏗 **Virtual Mining (Pre-Mainnet)** | 20%               | 200,000,000      | Rewards early participants via in-app "mining" (virtual tokens)       |
| 💎 **Staking Rewards Pool**         | 30%               | 300,000,000      | Distributed as rewards based on staking lock-up durations              |
| 🌍 **Ecosystem & Developer Grants** | 15%               | 150,000,000      | Funds allocated for ecosystem development and developer incentives     |
| 👥 **Team, Advisors & Reserve**     | 25%               | 250,000,000      | Allocated to the core team with a vesting schedule                     |
| 🔄 **Liquidity & Partnerships**     | 10%               | 100,000,000      | Reserved for exchange listings, liquidity pools, and strategic partners |

---

## ⛏ Virtual Mining Reward Model

The virtual mining mechanism rewards early adopters with virtual tokens that are later converted to mainnet tokens. The rewards follow a **time-decay function**:

```math
v(t) = V₀ / (1 + k * t)
```

Where:
- **V₀**: Initial mining reward rate.
- **k**: Decay constant.
- **t**: Time elapsed (in days).

This ensures that early participants earn higher rewards while gradually reducing inflation over time.

---

## 💰 Staking Reward Model

To encourage long-term commitment, staking rewards are based on a tiered multiplier:

```math
M(d) = 1 + α \cdot (d - 1)^β
```

Where:
- **d**: Lock-up duration in years.
- **α** and **β**: Adjustable parameters affecting reward scaling.

### 📈 Example Staking Multipliers:
- **1 year** → `M(1) = 1.0`
- **3 years** → `M(3) ≈ 1.57`
- **5 years** → `M(5) ≈ 2.6`
- **8 years** → `M(8) ≈ 4.70`

**Formula for staking rewards:**

```math
Reward_{staking} = A \times R \times M(d) \times d
```

Where **A** is the staked amount and **R** is the base APY (e.g., 8% per annum).

---

## 🏆 Team Vesting Schedule

To align team incentives with long-term success:
- **Cliff Period:** 1 year (no tokens released).
- **Vesting Duration:** 4 years (linear release after the cliff period).
- **Example Allocation:**
  - **Year 0-1:** 0 CVT released
  - **Year 1-4:** 250,000,000 CVT released gradually

---

## 🔥 Inflation Control & Governance

To maintain a sustainable supply, the following mechanisms are in place:
- **Minting for Staking:** Controlled inflation for staking rewards with a cap.
- **Token Burns:** Periodic burns based on governance votes.
- **Dynamic Adjustments:** Community governance can modify parameters (e.g., `V₀`, `k`, `α`, `β`).

---

## ✅ Summary
- **Pre-Mainnet Mining:** 20% of total supply, rewards decrease over time.
- **Staking Rewards:** 30% of total supply, tiered multipliers for long-term commitment.
- **Ecosystem & Grants:** 15% reserved for ecosystem growth.
- **Team Vesting:** 1-year cliff, 4-year linear release.
- **Liquidity & Partnerships:** 10% for strategic growth.

This model ensures a **fair, sustainable, and community-driven** token economy for Civitas Network.

🚀 **Join us in revolutionizing decentralized finance!**

