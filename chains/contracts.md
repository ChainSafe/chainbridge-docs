# Contracts

## Ethereum Contracts[¶](contracts.md#ethereum-contracts) <a id="ethereum-contracts"></a>

### Bridge Contract[¶](contracts.md#bridge-contract) <a id="bridge-contract"></a>

Users and relayers will interact with the `Bridge` contract. This delegates calls to the handler contracts for deposits and executing proposals.

```text
function deposit (uint8 destinationChainID, bytes32 resourceID, bytes calldata data)
```

### Handler Contracts[¶](contracts.md#handler-contracts) <a id="handler-contracts"></a>

To provide modularity and break out the necessary contract logic, the implementation uses a notion of handlers. A handler is defined for ERC20, ERC721 and generic transfers. These map directly to the Fungible, Non-Fungible, and generic transfer types.

A handler must fulfill two interfaces:

```text
// Will be called by the bridge contract to initiate a transfer
function deposit(uint8 destinationChainID, uint64 depositNonce, address depositer, bytes calldata data)
```

```text
// TODO: This would be more aptly named executeProposal
// Called by the bridge contract to complete a transfer
function executeDeposit(bytes calldata data)
```

The `calldata` field is the parameters required for the handler. The exact serialization is defined for each handler.

#### ERC20 & ERC721 Handlers[¶](contracts.md#erc20-erc721-handlers) <a id="erc20-erc721-handlers"></a>

These handlers share a lot of similarities.

These handlers are responsible for transferring ERC assets. They should provide the ability for the bridge to take ownership of tokens and release tokens to execute transfers.

Different configurations may require different interface interactions. For example, it may make sense to mint and burn a token that is originally from another chain. If supply needs to be controlled, transferring tokens in and out of a reserve may be desired instead. To support either case handlers should associate each resource ID/token contract with one of these:

* `transferFrom()` - The user approves the handler to move the tokens prior to initiating the transfer. The handler will call `transferFrom()` as part of the transfer initiation. For the inverse, the handler will call `transfer()` to release tokens from the handlers ownership.
* `mint()`/`burn()` - The user approves the handler to move the tokens prior to initiating the transfer. The handler will call `burnFrom()` as part of the transfer initiation. For the inverse, the handler will call `mint()` to release tokens to the recipient \(and must have privileges to do so\).

#### ERC20 Handler[¶](contracts.md#erc20-handler) <a id="erc20-handler"></a>

**Calldata for deposit\(\)¶**

| Data | Type | Location |
| :--- | :--- | :--- |
| Amount | uint256 | 0 - 31 |
| Recipient Address Length | uint256 | 32 - 63 |
| Recipient Address | bytes | 63 - END |

**Calldata for executeDeposit\(\)¶**

| Data | Type | Location |
| :--- | :--- | :--- |
| Amount | uint256 | 0 - 31 |
| Recipient Address Length | uint256 | 32 - 63 |
| Recipient Address | bytes | 64 - END |

#### ERC721 Handler[¶](contracts.md#erc721-handler) <a id="erc721-handler"></a>

**Metadata¶**

The `tokenURI` should be used as the `metadata` field if the contract supports the Metadata extension \(interface ID `0x5b5e139f`\).

**Calldata for deposit\(\)¶**

| Data | Type | Location |
| :--- | :--- | :--- |
| TokenID | uint256 | 0 - 31 |
| Recipient Address Length | uint256 | 32 - 63 |
| Recipient Address | bytes | 63 - END |

**Calldata for executeDeposit\(\)¶**

| Data | Type | Location |
| :--- | :--- | :--- |
| TokenID | uint256 | 0 - 31 |
| Recipient Address Length | uint256 | 32 - 63 |
| Recipient Address | bytes | 64 - 95 |
| Metadata Length | uint256 | 96 - 127 |
| Metadata | bytes | 128 - END |

#### Generic Handler[¶](contracts.md#generic-handler) <a id="generic-handler"></a>

As well as associating a resource ID to a contract address, the generic handler should allow specific functions on those contracts to be used. To allow for this we must:

1. Use [function selectors](https://solidity.readthedocs.io/en/v0.6.4/abi-spec.html#function-selector) to identify functions.
2. Require functions that accept `bytes` as a the only parameter **OR** require the data already be ABI encoded for the function

**Deposit¶**

In a generic context, a deposit is simply the initiation of a transfer of a piece of data. To \(optionally\) allow this data to be validated for transfer the deposit mechanism should pass the data to a specified function and proceed with the transfer if the call succeeds \(ie. does not revert\). A function selector of `0x00` should skip the deposit function call.

**Execute¶**

An execution function must be specified. When `executeDeposit()` is called on the handler it should pass the `metadata` field to the specified function.

**Calldata for deposit\(\)¶**

| Data | Type | Location |
| :--- | :--- | :--- |
| Metadata Length | uint256 | 0 - 31 |
| Metadata | bytes | 32 - END |

**Calldata for execute\(\)¶**

| Data | Type | Location |
| :--- | :--- | :--- |
| Metadata Length | uint256 | 0 - 31 |
| Metadata | bytes | 32 - END |

### Administration[¶](contracts.md#administration) <a id="administration"></a>

The contracts should be controlled by an admin account. This should control the relayer set, manage the resource IDs, and specify the handlers. It should also be able to pause and unpause transfers at any times.

