# Bridge Administrator and Node Endpoints

_Here we will configure the Bridge Administrator address as well as the endpoints of the network nodes we are seeking to bridge._


## Bridge Administrator

_This will be your "spending address" \(used to fund and invoke all transactions herein\)._


#### Generate Keypairs

This command will generate an Ethereum keypair to be used for a relayer. Celo is EVM-compatible, so we can use this same command for generating Celo accounts as well.

```bash
./chainbridge-core-example evm-cli accounts generate
```

The output of this command will provide us with an address and a private key. **USE IT ONLY FOR BRIDGE ADMINISTRATION OR MINTING TOKENS**

**_We suggest to store bridge administrator private key in environment variable for easier usage with CLI commands or_**\
_**keep note of the private key in a secure place as we will use it throughout the guide.**_

```bash
export BRIDGE_ADMIN_PRIVATE_KEY='**bridge admin private key**'
```


## Endpoints

Due to the number of queries our relayers make to each network, it is recommended to run your own nodes for the networks you are looking to bridge.

The below example shows two websocket endpoints from nodes we are running on our local machine.

```text
Network A (ETH): ws://localhost:2345
Network B (CELO): ws://localhost:6789
```


### Set Environment Variables

_We suggest to store node endpoints as environment variables for easier usage with the CLI commands._

```bash
export NODE_ENDPOINT_NETWORK_A='ws://localhost:2345'
export NODE_ENDPOINT_NETWORK_B='ws://localhost:6789'
```
