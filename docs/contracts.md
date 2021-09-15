# Contracts

[ToC]

**Bridge contract:**
*Users and relayers will interact with the Bridge contract. This delegates calls to the handler contracts for deposits and executing proposals.*

**Handler contracts:**
*To provide modularity and break out the necessary contract logic, the implementation uses a notion of handlers. A handler, in this example, is defined for ERC20 transfers. This maps directly to the Fungible transfer type.*

*These handlers are responsible for transferring ERC assets. They should provide the ability for the bridge to take ownership of tokens and release tokens to execute transfers.*
