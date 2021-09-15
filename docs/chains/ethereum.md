# Ethereum Implementation Specification

The solidity implementation of ChainBridge should consist of a central Bridge contract, and will delegate specific functionality to [handlers](ethereum.md#handler-contracts). Fungible and non-fungible compatibility should be focused on ERC20 and ERC721 tokens.

## Transfer Flow

### As Source Chain

1. Some user calls the `deposit` function on the bridge contract. A `depositRecord` is created on the bridge and a call is delgated to a handler contract specified by the provided `resourceID`.
2. The specified handler's `deposit` function validates the parameters provided by the user. If successful, a `depositRecord` is created on the handler.
3. If the call delegated to the handler is succesful, the bridge emits a `Deposit` event.
4. Relayers parse the `Deposit` event and retrieve the associated `DepositRecord` from the handler to construct a message.

### As Destination Chain

1. A Relayer calls `voteProposal` on the bridge contract. If a `proposal` corresponding with the parameters passed in does not exist, it is created and the Relayer's vote is recorded. If the proposal already exists, the Relayer's vote is simply recorded.
2. Once we have met some vote threshold for a `proposal`, the bridge emits a `ProposalFinalized` event.
3. Upon seeing a `ProposalFinalized` event, Relayers call the`executeDeposit`function on the bridge. `executeDeposit` delegates a call to a handler contract specified by the associated `resourceID`.
4. The specified handler's `executeDeposit` function validates the parameters provided and makes a call to some contract to complete the transfer.

