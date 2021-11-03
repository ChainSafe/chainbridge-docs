# Handlers Migration Guide

In this guide, we're going to walk through the steps necessary for a bridge administrator to complete when a customized ERC20/721/generic handler is to be used instead of the default ERC20/721/generic handler.

**NOTE:** this includes token migration as well as registering a new handler address. 

#### TODO:
- should this also assume that the new handler has been deployed previously?
- should bridge be paused first prior to migration?

### Table of Contents

1. [Overview](#overview)
2. [Migration](#migration)
#
## Overview
As explained within [eth-contracts](../chains/eth-contracts.md), these handlers are responsible for transferring ERC assets. They provide the bridge with the ability to take ownership of tokens and release tokens in order to execute transfers.

Different configurations may require different interface interactions. For example, it may make sense to mint and burn a token that is originally from another chain. If supply needs to be controlled, transferring tokens in and out of a reserve may be desired instead.

As a result, a dev may wish to implement their own custom handlers outside of the default handlers we have provided. In such an event, the handler must be deployed and then properly assigned a [resource ID](../spec.md#resource-id) to it in order for actions to be associated with this custom handler.

**NOTE:** _Within this guide we will be utilizing the `chainbridge-core-example` as a means of showcasing the CLI commands from the `chainbridge-core`. For help installing the `chainbridge-core-example`, see our [installation](../installation.md) guide._
&nbsp;  
## Migration
In the event that a default handler has already been deployed and a new, custom handler is to be used in its stead, a migration will need to occur.

This migration consists of **five** steps:
1. Pausing the bridge contract
2. Identifying total token balance stored within HandlerA (old)
3. Transferring total token balance stored within HandlerA (old) -> HandlerB (new)
4. Overwriting a mapping within the bridge contract: 

    a. [ResourceID => HandlerAddress](https://github.com/ChainSafe/chainbridge-solidity/blob/master/contracts/Bridge.sol#L40)
&nbsp;  
5. Unpausing the bridge contract
### Steps
1. Pause the bridge contract

In this first step, we will invoke the admin `pause` command which will freeze the bridge. During this time, both deposits and proposals will be disallowed. 

This is an important step to remember to take as a bridge administrator so as to prevent your bridge users from accidentally losing tokens during the migration of your handlers.

[Docs: Admin Pause](https://github.com/ChainSafe/chainbridge-core/blob/main/README.md#pause)

2. Identify total token balance stored within HandlerA (old)

Query the balance of the HandlerA (old) contract. This is a necessary step in order to identify how much token exists on the handlers so that, as the administrator, we know how much token we seek to remove or withdraw out of our ERC handler safe, as we will do in the next step.

There are few ways of accomplishing this, but if the contract is deployed to a network that utilizes a block explorer, simply using the explorer UI to query the handler contract's balance is likely the easiest way.

You can also utilize the CLI to query the balance of either: an [Externally Owned Account (EOA)](https://ethdocs.org/en/latest/contracts-and-transactions/account-types-gas-and-transactions.html) or a [Contract Account](https://ethdocs.org/en/latest/contracts-and-transactions/account-types-gas-and-transactions.html#contract-accounts). 

A demo example on how to do this with more context can be found [here](../transfer-and-balances.md#query-balances).

[Docs: ERC20 Balance](https://github.com/ChainSafe/chainbridge-core/blob/main/README.md#balance)

3. Withdraw total token balance from HandlerA (old) into HandlerB (new)

Once you know the total token balance that exists on HandlerA (old), utilize the admin CLI command `withdraw` in order to transfer out the tokens that exist on HandlerA (old), effectively allowing us to drain the contract of its entire token balance and setting the output of this action to be the newly deployed, custom handler, HandlerB (new).

**Notable Flags:**
- `--amount`: the amount of tokens to withdraw
- `--bridge`: the address of the bridge
- `--token`: the ERC20 or ERC721 token contract address
- `--handler`: the address of the handler to withdraw tokens from
- `--recipient`: the address to receive the withdrawn tokens
- `--decimals`: the number of decimals of the ERC20 token
```bash
./chainbridge-core-example \
evm-cli \
admin \
withdraw \
--url $NODE_ENDPOINT \
--privateKey BRIDGE_ADMIN_PRIVATE_KEY \
--amount 1000 \
--bridge 0x0 \
--token 0x0 \
--handler 0x0 \
--recipient 0x0 \
--decimals 18
```

[Docs: Admin Withdraw](https://github.com/ChainSafe/chainbridge-core/blob/main/README.md#withdraw)

4. Next, we will need to register the new handler

In this second-to-last step, we will register the new handler, HandlerB (new), and map it to a resource ID, used to associate an action with a resource.

**Notable Flags:**
- `--bridge`: the address of the bridge
- `--handler`: the address of the new handler to be registered
- `--target`: the address of the ERC20 or ERC721 token
- `--resourceId`: the resource ID to be registered
```bash
./chainbridge-core-example \
evm-cli \
bridge \
register-resource \
--url $NODE_ENDPOINT \
--privateKey BRIDGE_ADMIN_PRIVATE_KEY \
--bridge 0x0 \
--handler 0x0 \
--target 0x0 \
--resourceID 000000000000000000000000000000e389d61c11e5fe32ec1735b3cd38c69500
```

[Docs: Bridge Register-Resource](https://github.com/ChainSafe/chainbridge-core/blob/main/README.md#register-resource))

5. Lastly, we will unpause the bridge in order to resume service

In this final step, we will invoke the admin `unpause` command which will once again allow the bridge to accept both deposits and proposals.

[Docs: Admin Unpause](https://github.com/ChainSafe/chainbridge-core/blob/main/README.md#unpause)
