# Deployment Guide

In this guide, we're going to walk through the details of deploying a bridge between NetworkA (ETH) and NetworkB (CELO).

## Overview
[Overview](../index.md)

## Getting started

Before anything further can be done, we need to download and install some necessary software.

[Installation](../installation.md)

### Bridge Administrator and Node Endpoints

[Bridge Administrator and Node Endpoints](../bridge-admin-node-endpoints.md)

### Relayers

[Relayers](../relayers.md)

### Smart Contracts

[Smart Contracts](../chains/eth-contracts.md)

### Deployed Contract Table
_This is a digest of the contracts needed for the ChainBridge to operate._

**Keep note of these addresses as we will use them throughout the guide.**
```
NetworkA: ChainID: 1
================================================================
Bridge:             0x0 (TBD)
----------------------------------------------------------------
Erc20 Handler:      0x0 (TBD)
----------------------------------------------------------------
Erc20:              0x0 (TBD)
----------------------------------------------------------------
================================================================

Network B: ChainID: 0
================================================================
Bridge:             0x0 (TBD)
----------------------------------------------------------------
Erc20 Handler:      0x0 (TBD)
----------------------------------------------------------------
Erc20:              0x0 (TBD)

ResourceID: 000000000000000000000000000000e389d61c11e5fe32ec1735b3cd38c69500 
```
*^The ResourceID shown above provides us with a way to associate some action on a source chain to some action on a destination chain.*

*More about ResourceIDs [here](../spec.md#resource-id).*

## Preparations: NetworkA (ETH)

### Deploy Bridge, ERC20 and ERC20 Handler Contracts

*Deploy all of the contracts required for bridging*

**Notable flags:**
1. **relayerThreshold:** a relayer threshold of 2 (meaning 2 votes are required for a proposal to pass)
2. **relayers:** a string list of our relayer addresses (from above)

```bash
./chainbridge-core-example \
evm-cli \
deploy \
--url $NODE_ENDPOINT_NETWORKA \
--privateKey BRIDGE_ADMIN_PRIVATE_KEY \
--all \
--relayerThreshold 2 \
--chainId 1 \
--relayers "0x010f478794f9b1917f9d2d31865f516729Be6208,0x42F567FEA3Cf5F27186344F04A5774A753B55b39,0xb7d584fE0085fEb275FAc27deaCddA404AdD949A"
```

### Register Resource

*Register a resource ID with a contract address for a handler*

```bash
./chainbridge-core-example \
evm-cli \
bridge \
register-resource \
--url $NODE_ENDPOINT_NETWORKA \
--privateKey BRIDGE_ADMIN_PRIVATE_KEY \
--bridge 0x0 \
--handler 0x0 \
--target 0x0 \
--resourceId 000000000000000000000000000000e389d61c11e5fe32ec1735b3cd38c69500
```

### Set ERC20 as Mintable/Burnable, Add Minter, Mint Tokens

### Set ERC20 as Mintable/Burnable

*This sets an ERC-20 handler as burnable*

```bash
./chainbridge-core-example \
evm-cli \
bridge \
set-burn \
--url $NODE_ENDPOINT_NETWORKA \
--privateKey BRIDGE_ADMIN_PRIVATE_KEY \
--handler 0x0 \
--bridge 0x0 \
--tokenContract 0x0
```

### Add Minter

*This sets an ERC-20 handler as mintable*

```bash
./chainbridge-core-example \
evm-cli \
erc20 \
add-minter \
--url $NODE_ENDPOINT_NETWORKA \
--privateKey BRIDGE_ADMIN_PRIVATE_KEY \
--erc20Address 0x0 \
--minter 0x0
```

### Mint Tokens

*Mint ERC-20 tokens*

```bash
./chainbridge-core-example \
evm-cli \
erc20 \
mint \
--url $NODE_ENDPOINT_NETWORKA \
--privateKey BRIDGE_ADMIN_PRIVATE_KEY \
--amount 10 \
--erc20Address 0x0
```

## Preparations: NetworkB (CELO)

### Deploy Bridge, ERC20 and ERC20 Handler Contracts

*Deploy all of the contracts required for bridging*

**Notable flags:**
1. **relayerThreshold:** a relayer threshold of 2 (meaning 2 votes are required for a proposal to pass)
2. **relayers:** a string list of our relayer addresses (from above)

```bash
./chainbridge-core-example \
celo-cli \
deploy \
--url $NODE_ENDPOINT_NETWORKB \
--privateKey BRIDGE_ADMIN_PRIVATE_KEY \
--all \
--relayerThreshold 2 \
--chainId 0 \
--relayers "0x010f478794f9b1917f9d2d31865f516729Be6208,0x42F567FEA3Cf5F27186344F04A5774A753B55b39,0xb7d584fE0085fEb275FAc27deaCddA404AdD949A"
```

### Register Resource

*Register a resource ID with a contract address for a handler*

```bash
./chainbridge-core-example \
celo-cli \
bridge \
register-resource \
--url $NODE_ENDPOINT_NETWORKB \
--privateKey BRIDGE_ADMIN_PRIVATE_KEY \
--bridge 0x0 \
--handler 0x0 \
--target 0x0 \
--resourceId 000000000000000000000000000000e389d61c11e5fe32ec1735b3cd38c69500
```

### Set ERC20 as Mintable/Burnable, Add Minter, Mint Tokens

### Set ERC20 as Mintable/Burnable

*This sets an ERC-20 handler as burnable*

```bash
./chainbridge-core-example \
celo-cli \
bridge \
set-burn \
--url $NODE_ENDPOINT_NETWORKB \
--privateKey BRIDGE_ADMIN_PRIVATE_KEY \
--handler 0x0 \
--bridge 0x0 \
--tokenContract 0x0
```

### Add Minter

*This sets an ERC-20 handler as mintable*

```bash
./chainbridge-core-example \
celo-cli \
erc20 \
add-minter \
--url $NODE_ENDPOINT_NETWORKB \
--privateKey BRIDGE_ADMIN_PRIVATE_KEY \
--erc20Address 0x0 \
--minter 0x0
```

### Mint Tokens

*Mint ERC-20 tokens*

```bash
./chainbridge-core-example \
celo-cli \
erc20 \
mint \
--url $NODE_ENDPOINT_NETWORKB \
--privateKey BRIDGE_ADMIN_PRIVATE_KEY \
--amount 10 \
--erc20Address 0x0
```
