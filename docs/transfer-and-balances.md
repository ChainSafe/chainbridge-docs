# Transfer and Query Balances

## Transfer: NetworkA > NetworkB

*Let's transfer some tokens from NetworkA (ETH) to NetworkB (CELO).*

### Approve Tokens For Transfer

*First, we must approve the ERC20 contract address to allow for a specified amount of token to be transferred by the provided recipient address.*

*In this case, we're going to be approving 100 tokens to be transferred by the ERC20 handler contract.*

Flags:
1. **recipient:** the ERC20 Handler contract from the [deployed contract table](#Deployed-Contract-Table)
2. **erc20address:** the ERC20 contract from the [deployed contract table](#Deployed-Contract-Table) 

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

*In this step, we're going to be transferring 1 ERC20 token.*

Flags:
1. **bridge:** the bridge contract from the [deployed contract table](#Deployed-Contract-Table)
2. **recipient:** the address to receive the tokens
3. **resourceId:** the resource ID from the [deployed contract table](#Deployed-Contract-Table) 

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
--destId 0 \
--resourceId 000000000000000000000000000000e389d61c11e5fe32ec1735b3cd38c69500 \
--decimals 18
```

## Transfer: NetworkB > NetworkA

*Let's transfer some tokens from NetworkB (CELO) to NetworkA (ETH).*

### Approve Tokens For Transfer

*Just as in the above case, we must approve the ERC20 contract address to allow for a specified amount of token to be transferred by the provided recipient address.*

*We're going to be approving 100 tokens to be transferred by the ERC20 handler contract.*

Flags:
1. **recipient:** the ERC20 Handler contract from the [deployed contract table](#Deployed-Contract-Table)
2. **erc20address:** the ERC20 contract from the [deployed contract table](#Deployed-Contract-Table) 

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

*In this step, we're going to be transferring 100 ERC20 tokens.*

Flags:
1. **bridge:** the bridge contract from the [deployed contract table](#Deployed-Contract-Table)
2. **recipient:** the address to receive the tokens
3. **resourceId:** the resource ID from the [deployed contract table](#Deployed-Contract-Table) 

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
--destId 1 \
--resourceId 000000000000000000000000000000e389d61c11e5fe32ec1735b3cd38c69500 \
--decimals 18
```

## Query Balances

*Query balance of an account from an ERC20 contract.*

### NetworkA

*In this step we'll query the specific ERC20 token balance of an Ethereum address on NetworkA.*

Flags:
1. **erc20address:** the ERC20 contract from the [deployed contract table](#Deployed-Contract-Table)
2. **accountAddress:** the address who's balance we wish to know


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

*Now, we'll query the specific ERC20 token balance of an Ethereum address on NetworkB.*

Flags:
1. **erc20address:** the ERC20 contract from the [deployed contract table](#Deployed-Contract-Table)
2. **accountAddress:** the address who's balance we wish to know

```bash
./chainbridge-core-example \
celo-cli \
erc20 \
balance \
--url $NODE_ENDPOINT_NETWORKB \
--erc20Address 0x0 \
--accountAddress 0x284D2Cb760D5A952f9Ea61fd3179F98a2CbF0B3E
```
