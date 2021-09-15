# Background

ChainBridge is an extensible cross-chain communication protocol.

A bridge contract on each chain forms either side of a bridge. Handler contracts allow for customizable behavior upon receiving transactions to and from the bridge; for example, locking up an asset on one side and minting a new one on the other. It is highly customizable- you can deploy a handler contract to perform any action you like.

In its current state ChainBridge operates under a trusted federation model. Deposit events on one chain are detected by a trusted set of off-chain relayers who await finality, submit events to the other chain and vote on submissions to reach acceptance triggering the appropriate handler.
