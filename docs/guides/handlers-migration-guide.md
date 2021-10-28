# Handlers Migration Guide

In this guide, we're going to walk through the steps necessary for a bridge administrator to complete when a customized ERC20/721/generic handler is to be used instead of the default ERC20/721/generic handler.

**NOTE:** this includes token migration as well as registering a new handler address. 

#### TODO:
- should this also assume that the new handler has been deployed previously?

### Table of Contents

1. [Overview](#overview)
2. [Migration](#migration)
#
## Overview
As explained within [eth-contracts](../chains/eth-contracts.md), these handlers are responsible for transferring ERC assets. They provide the bridge with the ability to take ownership of tokens and release tokens in order to execute transfers.

Different configurations may require different interface interactions. For example, it may make sense to mint and burn a token that is originally from another chain. If supply needs to be controlled, transferring tokens in and out of a reserve may be desired instead.

As a result, a dev may wish to implement their own custom handlers outside of the default handlers we have provided. In such an event, the handler must be deployed and then properly assigned a [resource ID](../spec.md#resource-id) to it in order for actions to be associated with this custom handler.
&nbsp;  
&nbsp;  
## Migration
In the event that a default handler has already been deployed and a new, custom handler is to be used in its stead, a migration will need to occur.

This migration consists of two steps:
1. Transferring all value from HandlerA(old) -> HandlerB(new)
2. Overwriting the mapping within the bridge contract: 

    a. [ResourceID => HandlerAddress](https://github.com/ChainSafe/chainbridge-solidity/blob/master/contracts/Bridge.sol#L40)

&nbsp;  
&nbsp;  
### Steps
