# 🌉 <b> Overview </b>

## Summary

ChainBridge is an extensible cross-chain communication protocol. It currently supports bridging between EVM and Substrate based chains.

A bridge contract (or pallet in Substrate) on each chain forms either side of a bridge. Handler contracts allow for customizable behavior upon receiving transactions to and from the bridge. For example locking up an asset on one side and minting a new one on the other. Its highly customizable - you can deploy a handler contract to perform any action you like.

In its current state ChainBridge operates under a trusted federation model. Deposit events on one chain are detected by a trusted set of off-chain relayers who await finality, submit events to the other chain and vote on submissions to reach acceptance triggering the appropriate handler.

Research is currently underway to reduce the levels of trust required and move toward a fully trust-less bridge.

![](./img/system-flow.png)

## Relevant repos

### [ChainBridge](https://github.com/ChainSafe/ChainBridge)
This is the core bridging software that Relayers run between chains.

### [chainbridge-solidity](https://github.com/ChainSafe/chainbridge-solidity) 
The Solidity contracts required for chainbridge. Includes deployment and interaction CLI.
    
### [chainbridge-substrate](https://github.com/ChainSafe/chainbridge-substrate)
A substrate pallet that can be integrated into a chain, as well as an example pallet to demonstrate chain integration.

### [chainbridge-utils](https://github.com/ChainSafe/chainbridge-utils)
A collection of packages used by the core bridging software.

### [chainbridge-deploy](https://github.com/ChainSafe/ChainBridge)
Some tooling to help with deployments.
