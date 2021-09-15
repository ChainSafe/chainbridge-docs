# Bridge Administrator and Node Endpoints

[ToC]

_Here we will configure the Bridge Administrator address as well as the endpoints of the network nodes we are seeking to bridge._

## Bridge Administrator
_This will be your "spending address" (used to fund and invoke all transactions herein)._

**USE IT ONLY FOR BRIDGE ADMINISTRATION OR MINTING TOKENS**
```bash
Address: 0x284D2Cb760D5A952f9Ea61fd3179F98a2CbF0B3E
Private key: **stored elsewhere**
```

## Endpoints
Due to the number of queries our relayers make to each network, it is recommended to run your own nodes for the networks you are looking to bridge.

The below example shows two websocket endpoints from nodes we are running on our local machine.

```
NetworkA (ETH): ws://localhost:2345
NetworkB (CELO): ws://localhost:6789
```

### Set Environment Variables

*Set node endpoints as environment variables to be used with the CLI commands.*

```bash
export NODE_ENDPOINT_NETWORKA='ws://localhost:2345'
export NODE_ENDPOINT_NETWORKB='ws://localhost:6789'
```

_Store Bridge Administrator private key in environment variable to be used with the CLI commands._
```bash
export BRIDGE_ADMIN_PRIVATE_KEY=''
```
