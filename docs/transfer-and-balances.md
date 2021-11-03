# Transfer and Query Balances

## Transfer: NetworkA &gt; NetworkB

_Let's transfer some tokens from NetworkA \(ETH\) to NetworkB \(CELO\)._

### Approve Tokens For Transfer

_First, we must approve the ERC20 contract address to allow for a specified amount of token to be transferred by the provided recipient address._

_In this case, we're going to be approving 100 tokens to be transferred by the ERC20 handler contract._

Flags: 1. **recipient:** the ERC20 Handler contract from the [deployed contract table](transfer-and-balances.md#Deployed-Contract-Table) 2. **erc20address:** the ERC20 contract from the [deployed contract table](transfer-and-balances.md#Deployed-Contract-Table)

```bash
./chainbridge-core-example \
evm-cli \
erc20 \
approve \
--url $NODE_ENDPOINT_NETWORKA \
--privateKey BRIDGE_ADMIN_PRIVATE_KEY \
--erc20address 0x0 \
--amount 100 \
--recipient 0x0 \
--decimals 18
```

### Transfer Tokens

_In this step, we're going to be transferring 1 ERC20 token._

Flags: 1. **bridge:** the bridge contract from the [deployed contract table](transfer-and-balances.md#Deployed-Contract-Table) 2. **recipient:** the address to receive the tokens 3. **resourceId:** the resource ID from the [deployed contract table](transfer-and-balances.md#Deployed-Contract-Table)

```bash
./chainbridge-core-example \
evm-cli \
erc20 \
deposit \
--url $NODE_ENDPOINT_NETWORKA \
--privateKey BRIDGE_ADMIN_PRIVATE_KEY \
--bridge 0x0 \
--recipient 0x0 \
--amount 1 \
--domainId 0 \
--resourceId 000000000000000000000000000000e389d61c11e5fe32ec1735b3cd38c69500 \
--decimals 18
```

## Transfer: NetworkB &gt; NetworkA

_Let's transfer some tokens from NetworkB \(CELO\) to NetworkA \(ETH\)._

### Approve Tokens For Transfer

_Just as in the above case, we must approve the ERC20 contract address to allow for a specified amount of token to be transferred by the provided recipient address._

_We're going to be approving 100 tokens to be transferred by the ERC20 handler contract._

Flags: 1. **recipient:** the ERC20 Handler contract from the [deployed contract table](transfer-and-balances.md#Deployed-Contract-Table) 2. **erc20address:** the ERC20 contract from the [deployed contract table](transfer-and-balances.md#Deployed-Contract-Table)

```bash
./chainbridge-core-example \
celo-cli \
erc20 \
approve \
--url $NODE_ENDPOINT_NETWORKB \
--privateKey BRIDGE_ADMIN_PRIVATE_KEY \
--erc20address 0x0 \
--amount 100 \
--recipient 0x0 \
--decimals 18
```

### Transfer Tokens

_In this step, we're going to be transferring 100 ERC20 tokens._

Flags: 1. **bridge:** the bridge contract from the [deployed contract table](transfer-and-balances.md#Deployed-Contract-Table) 2. **recipient:** the address to receive the tokens 3. **resourceId:** the resource ID from the [deployed contract table](transfer-and-balances.md#Deployed-Contract-Table)

```bash
./chainbridge-core-example \
celo-cli \
erc20 \
deposit \
--url $NODE_ENDPOINT_NETWORKB \
--privateKey BRIDGE_ADMIN_PRIVATE_KEY \
--bridge 0x0 \
--recipient 0x0 \
--amount 100 \
--domainId 1 \
--resourceId 000000000000000000000000000000e389d61c11e5fe32ec1735b3cd38c69500 \
--decimals 18
```

## Query Balances

_Query balance of an account from an ERC20 contract._

### NetworkA

_In this step we'll query the specific ERC20 token balance of an Ethereum address on NetworkA._

Flags: 1. **erc20address:** the ERC20 contract from the [deployed contract table](transfer-and-balances.md#Deployed-Contract-Table) 2. **accountAddress:** the address who's balance we wish to know

```bash
./chainbridge-core-example \
evm-cli \
erc20 \
balance \
--url $NODE_ENDPOINT_NETWORKA \
--erc20Address 0x0 \
--accountAddress 0x284D2Cb760D5A952f9Ea61fd3179F98a2CbF0B3E
```

### NetworkB

_Now, we'll query the specific ERC20 token balance of an Ethereum address on NetworkB._

Flags: 1. **erc20address:** the ERC20 contract from the [deployed contract table](transfer-and-balances.md#Deployed-Contract-Table) 2. **accountAddress:** the address who's balance we wish to know

```bash
./chainbridge-core-example \
celo-cli \
erc20 \
balance \
--url $NODE_ENDPOINT_NETWORKB \
--erc20Address 0x0 \
--accountAddress 0x284D2Cb760D5A952f9Ea61fd3179F98a2CbF0B3E
```

