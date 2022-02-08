# Deployment Guide

In this guide, we're going to walk through the details of deploying a bridge between Network A (ETH) and Network B (CELO).


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



## Preparations: Network A (ETH)

### Deploy Bridge, ERC20 and ERC20 Handler Contracts

_Deploy all of the contracts required for bridging_

**Notable flags:**&#x20;

*  **relayerThreshold:** a relayer threshold of 2 (meaning 2 votes are required for a proposal to pass)
*  **relayers:** a string list of our relayer addresses

```bash
./chainbridge-core-example \
evm-cli \
deploy \
--url $NODE_ENDPOINT_NETWORK_A \
--private-key $BRIDGE_ADMIN_PRIVATE_KEY \
--all \
--relayer-threshold 2 \
--domain 1 \
--relayers $RELAYER_1_ADDRESS,$RELAYER_2_ADDRESS,$RELAYER_3_ADDRESS \
--erc20-name EthTestToken \
--erc20-symbol eTST \
--fee 0
```


### Deployed Contract Table

_This is the expected output of `deploy` command._

```text
 Deployed contracts
================================================================
Bridge:             **bridge address**
----------------------------------------------------------------
Erc20:              **ERC20 contract address**
----------------------------------------------------------------
Erc20 Handler:      **ERC20 handler address**
----------------------------------------------------------------
Erc721:             **ERC721 contract address**
----------------------------------------------------------------
Erc721 Handler:     **ERC721 handler address**
----------------------------------------------------------------
Generic Handler:    **generic handler address**
----------------------------------------------------------------
================================================================
```

**We suggest that you set all addresses as environment variables for easier usage or**\
**keep note of these addresses as we will use them throughout the guide.**

## Set environment variables for Network A
```bash
export BRIDGE_ADDRESS_NETWORK_A='**bridge address**'
export ERC20_CONTRACT_ADDRESS_NETWORK_A='**ERC20 contract address**'
export ERC20_HANDLER_ADDRESS_NETWORK_A='**ERC20 handler address**'
export ERC721_CONTRACT_ADDRESS_NETWORK_A='**ERC721 contract address**'
export ERC721_HANDLER_ADDRESS_NETWORK_A='**ERC721 handler address**'
export GENERIC_HANDLER_ADDRESS_NETWORK_A='**generic handler address**'
```


### Register Resource

_Register a resource with a contract address for a handler_

>**Note:** Same resource has to be registered across all bridging chains (in our case  0x000A01, which is arbitrary)

For ease of use we're gonna store our resource ID in an environment variable

```bash
export RESOURCE_ID_1=0x000A01
```
Then run the following CLI command:

```bash
./chainbridge-core-example \
evm-cli \
bridge \
register-resource \
--url $NODE_ENDPOINT_NETWORK_A \
--private-key $BRIDGE_ADMIN_PRIVATE_KEY \
--bridge $BRIDGE_ADDRESS_NETWORK_A \
--handler $ERC20_HANDLER_ADDRESS_NETWORK_A \
--target $ERC20_CONTRACT_ADDRESS_NETWORK_A \
--resource $RESOURCE_ID_1
```

_^The Resource ID shown above provides us with a way to associate some action on a source chain to some action on a destination chain._

_More about ResourceIDs_ [_here_](../spec.md#resource-id)_._


## Set ERC20 as Mintable/Burnable, Add Minter, Mint Tokens

### Set ERC20 as Mintable/Burnable

_This sets an ERC-20 handler as burnable_

```bash
./chainbridge-core-example \
evm-cli \
bridge \
set-burn \
--url $NODE_ENDPOINT_NETWORK_A \
--private-key $BRIDGE_ADMIN_PRIVATE_KEY \
--handler $ERC20_HANDLER_ADDRESS_NETWORK_A \
--bridge $BRIDGE_ADDRESS_NETWORK_A \
--token-contract $ERC20_CONTRACT_ADDRESS_NETWORK_A
```


### Add Minter

_This sets an ERC-20 handler as mintable_

```bash
./chainbridge-core-example \
evm-cli \
erc20 \
add-minter \
--url $NODE_ENDPOINT_NETWORK_A \
--private-key $BRIDGE_ADMIN_PRIVATE_KEY \
--contract $ERC20_CONTRACT_ADDRESS_NETWORK_A \
--minter $ERC20_HANDLER_ADDRESS_NETWORK_A
```


### Mint Tokens

_Mint ERC-20 tokens_

```bash
./chainbridge-core-example \
evm-cli \
erc20 \
mint \
--url $NODE_ENDPOINT_NETWORK_A \
--private-key $BRIDGE_ADMIN_PRIVATE_KEY \
--amount 10 \
--decimals 18 \
--contract $ERC20_CONTRACT_ADDRESS_NETWORK_A \
--recipient '** address to receive minted tokens**'
```


### Query Balance

_Query balance of an account from an ERC20 contract_

```bash
./chainbridge-core-example \
evm-cli \
erc20 \
balance \
--url $NODE_ENDPOINT_NETWORK_A \
--contract $ERC20_CONTRACT_ADDRESS_NETWORK_A \
--address '**account address to query**'
```


## Preparations: Network B (CELO)

### Deploy Bridge, ERC20 and ERC20 Handler Contracts

_Deploy all of the contracts required for bridging_

```bash
./chainbridge-core-example \
celo-cli \
deploy \
--url $NODE_ENDPOINT_NETWORK_B \
--private-key $BRIDGE_ADMIN_PRIVATE_KEY \
--all \
--relayer-threshold 2 \
--domain 1 \
--relayers $RELAYER_1_ADDRESS,$RELAYER_2_ADDRESS,$RELAYER_3_ADDRESS \
--erc20-name CeloTestToken \
--erc20-symbol cTST \
--fee 0
```


### Deployed Contract Table

_This is the expected output of `deploy` command._

```text
 Deployed contracts
================================================================
Bridge:             **bridge address**
----------------------------------------------------------------
Erc20:              **ERC20 contract address**
----------------------------------------------------------------
Erc20 Handler:      **ERC20 handler address**
----------------------------------------------------------------
Erc721:             **ERC721 contract address**
----------------------------------------------------------------
Erc721 Handler:     **ERC721 handler address**
----------------------------------------------------------------
Generic Handler:    **generic handler address**
----------------------------------------------------------------
================================================================
```

**We suggest that you set all addresses as environment variables for easier usage or**\
**keep note of these addresses as we will use them throughout the guide.**

## Set environment variables for Network B
```bash
export BRIDGE_ADDRESS_NETWORK_B='**bridge address**'
export ERC20_CONTRACT_ADDRESS_NETWORK_B='**ERC20 contract address**'
export ERC20_HANDLER_ADDRESS_NETWORK_B='**ERC20 handler address**'
export ERC721_CONTRACT_ADDRESS_NETWORK_B='**ERC721 contract address**'
export ERC721_HANDLER_ADDRESS_NETWORK_B='**ERC721 handler address**'
export GENERIC_HANDLER_ADDRESS_NETWORK_B='**generic handler address**'
```


### Register Resource

_Register a resource with a contract address for a handler_

```bash
./chainbridge-core-example \
celo-cli \
bridge \
register-resource \
--url $NODE_ENDPOINT_NETWORK_B \
--private-key $BRIDGE_ADMIN_PRIVATE_KEY \
--bridge $BRIDGE_ADDRESS_NETWORK_B \
--handler $ERC20_HANDLER_ADDRESS_NETWORK_B \
--target $ERC20_CONTRACT_ADDRESS_NETWORK_B \
--resource $RESOURCE_ID_1
```


## Set ERC20 as Mintable/Burnable, Add Minter, Mint Tokens

### Set ERC20 as Mintable/Burnable

_This sets an ERC-20 handler as burnable_

```bash
./chainbridge-core-example \
celo-cli \
bridge \
set-burn \
--url $NODE_ENDPOINT_NETWORK_B \
--private-key $BRIDGE_ADMIN_PRIVATE_KEY \
--handler $ERC20_HANDLER_ADDRESS_NETWORK_B \
--bridge $BRIDGE_ADDRESS_NETWORK_B \
--token-contract $ERC20_CONTRACT_ADDRESS_NETWORK_B
```


### Add Minter

_This sets an ERC-20 handler as mintable_

```bash
./chainbridge-core-example \
celo-cli \
erc20 \
add-minter \
--url $NODE_ENDPOINT_NETWORK_B \
--private-key $BRIDGE_ADMIN_PRIVATE_KEY \
--contract $ERC20_CONTRACT_ADDRESS_NETWORK_B \
--minter $ERC20_HANDLER_ADDRESS_NETWORK_B
```


### Mint Tokens

_Mint ERC-20 tokens_

```bash
./chainbridge-core-example \
celo-cli \
erc20 \
mint \
--url $NODE_ENDPOINT_NETWORK_B \
--private-key $BRIDGE_ADMIN_PRIVATE_KEY \
--amount 10 \
--decimals 18 \
--contract $ERC20_CONTRACT_ADDRESS_NETWORK_B \
--recipient '** address to receive minted tokens**'
```

### Query Balance

_Query balance of an account from an ERC20 contract_

```bash
./chainbridge-core-example \
celo-cli \
erc20 \
balance \
--url $NODE_ENDPOINT_NETWORK_B \
--contract $ERC20_CONTRACT_ADDRESS_NETWORK_B \
--address '**account address to query**'
```
