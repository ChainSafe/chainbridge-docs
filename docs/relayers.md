# Relayers

The relayers perform the service of validating transfers across the ChainBridge. With 3 relayers serving as the distributed bridging authorities, proposal events \(propose/execute\) which are responsible for either the issuance or consumption of tokens, among other things, are communicated to their corresponding chain contracts when/if a consensus is reached between this group.

**DO NOT USE THE RELAYERS' PRIVATE KEYS UNLESS YOU ARE 100% SURE WHY ARE YOU DOING THIS**

### Generate Keypairs

This command will generate an Ethereum keypair to be used for a relayer. Celo is EVM-compatible, so we can use this same command for generating Celo accounts as well.

```bash
./chainbridge-core-example evm-cli accounts generate
```

We will run this command **3 times** in order to generate accounts for the relayers; results shown below.

**NOTE:** The below keypairs are not to be used in production; these are for example only.

**Relayer 0:**

```bash
Address: 0x010f478794f9b1917f9d2d31865f516729Be6208
Private key: **stored elsewhere*
```

**Relayer 1:**

```bash
Address: 0x42F567FEA3Cf5F27186344F04A5774A753B55b39
Private key: **stored elsewhere*
```

**Relayer 2:**

```bash
Address: 0xb7d584fE0085fEb275FAc27deaCddA404AdD949A
Private key: **stored elsewhere*
```

**Keystore Password:** This is a sample password for your keystore. This password should be more secure when using in a production environment, but we are using the below as an example.

```bash
1234567890
```

## Clone ChainBridge-Relayers Repository

Each Relayer will need to access keystore, config and blockstore files. These files can be stored conveniently in directories to be then accessed by the relayer. We have created a repository to provide a sample relayer setup and directory structure for convenience.

```bash
git clone https://github.com/chainsafe/chainbridge-relayers
```

_Directory structure:_

```bash
ls

README.md        config0            keys0
blockstore0        config1            keys1
blockstore1        config2            keys2
blockstore2        docker-compose.yml    prometheus
```

## Generate Keystore Files

_This command imports a keystore to be used for invoking bridge transfers and issuing commands._

#### In the below example, we will use the private key and keystore password for Relayer0 to import a keystore.

```bash
./chainbridge-core-example evm-cli accounts import --privateKey 68055bbd998453ac3c5242da290bab64dccf363fd3c0832ba692ff5de03895d7 --password 1234567890
```

This should be run **3 times**, once for each relayer, using the corresponding private key of each relayer for each invocation.

**The result should be moved into the keys directory corresponding to the relayer index.**

Example:

```bash
ls keys*

keys0:
0x010f478794f9b1917f9d2d31865f516729Be6208.key

keys1:
0x42F567FEA3Cf5F27186344F04A5774A753B55b39.key

keys2:
0xb7d584fE0085fEb275FAc27deaCddA404AdD949A.key
```

## Fund Bridge Administrator and Relayers

Both the bridge admin and relayer accounts should hold a small amount of funds in order to send transactions. The amount needed is relative to how much usage the bridge will get, so it is recommended to monitor the balances often to ensure sufficient balance at all times.

**Addresses to Fund:**

```text
# Bridge Admin
0x284D2Cb760D5A952f9Ea61fd3179F98a2CbF0B3E

# Relayers
0x010f478794f9b1917f9d2d31865f516729Be6208
0x42F567FEA3Cf5F27186344F04A5774A753B55b39
0xb7d584fE0085fEb275FAc27deaCddA404AdD949A
```

