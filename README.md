# FitnessRewards

FitnessRewards is a blockchain-based system built on the Stacks blockchain that tracks workout achievements and distributes rewards to incentivize fitness activities.

## Features

- **Activity Tracking**: Record and verify workout activities on the blockchain
- **Proportional Rewards**: Earn rewards based on your contribution to the overall activity pool
- **Transparent Distribution**: Fair and transparent bonus allocation
- **Immutable Records**: Blockchain-based records ensure data integrity

## Smart Contract Functions

### Administration
- `initialize`: Set up the FitnessRewards system with an administrator
- `allocate-bonuses`: Calculate and distribute bonus points based on time elapsed

### Athlete Functions
- `add-activities`: Record new workout activities and add them to your total
- `claim`: Claim your accumulated activities and proportional bonuses

## Getting Started

1. Clone this repository
2. Install [Clarinet](https://github.com/hirosystems/clarinet) for local development
3. Run `clarinet check` to verify the contract
4. Deploy using Clarinet or the Stacks CLI

## For Athletes

Athletes can record their workout activities and claim rewards proportional to their contribution to the overall fitness community.

## For Fitness Programs

Fitness programs can use this system to incentivize consistent workout habits and create a competitive yet supportive community environment.

## Technical Details

- Activities are tracked per athlete address
- Bonuses accumulate over time based on block height
- Rewards are distributed proportionally based on contribution to the activity pool
- All transactions are recorded on the Stacks blockchain for transparency