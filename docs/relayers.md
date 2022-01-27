# Relayers

The relayers perform the service of validating transfers across the ChainBridge. With 3 relayers serving as the distributed bridging authorities, proposal events \(propose/execute\) which are responsible for either the issuance or consumption of tokens, among other things, are communicated to their corresponding chain contracts when/if a consensus is reached between this group.

**DO NOT USE THE RELAYERS' PRIVATE KEYS UNLESS YOU ARE 100% SURE WHY ARE YOU DOING THIS**

### Generate Keypairs

This command will generate an Ethereum keypair to be used for a relayer. Celo is EVM-compatible, so we can use this same command for generating Celo accounts as well.

```bash
./chainbridge-core-example evm-cli accounts generate
```

We will run this command **3 times** in order to generate accounts for the relayers.

## Generate Keystore Files

_This command imports a keystore to be used for invoking bridge transfers and issuing commands._

#### In the below example, we will use the private key and keystore password for Relayer 1 to import a keystore.

**Keystore Password:** This is a sample password for your keystore. This password should be more secure when using in a production environment, but we are using the below as an example.

```bash
./chainbridge-core-example evm-cli accounts import --privateKey **relayer 1 private key** --password 1234567890
```

This should be run **3 times**, once for each relayer, using the corresponding private key of each relayer for each invocation.

**The result should be moved into the keys directory corresponding to the relayer index.**

Example:

```bash
ls keys*

**relayer 1 address**.key
**relayer 2 address**.key
**relayer 3 address**.key
```
_We suggest to store relayer addresses in environment variables for easier usage with CLI commands._

```bash
export RELAYER_1_ADDRESS = '**relayer 1 address**'
export RELAYER_2_ADDRESS = '**relayer 2 address**'
export RELAYER_3_ADDRESS = '**relayer 3 address**'
```

## Fund Bridge Administrator and Relayers

Both the bridge admin and relayer accounts should hold a small amount of funds in order to send transactions. The amount needed is relative to how much usage the bridge will get, so it is recommended to monitor the balances often to ensure sufficient balance at all times.

**Addresses to Fund:**

```text
# Bridge Admin
**bridge admin address**

# Relayers
**relayer 1 address**
**relayer 2 address**
**relayer 3 address**
```
