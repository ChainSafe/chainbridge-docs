# Running Locally
## Prerequisites

- Docker (Note: docker-compose now comes preinstalled with Docker)
- chainbridge `v1.1.1` binary (see [README](https://github.com/chainsafe/chainbridge/#building))
- cb-sol-cli (see [README](https://github.com/ChainSafe/chainbridge-deploy/tree/master/cb-sol-cli#cb-sol-cli-documentation))

# Steps To Get Started
1. [`Start Local Chains`](#start-local-chains)
2. [`Connect to PolkadotJS Portal`](#connect-to-polkadotjs-portal)
3. [`Deploy Contracts`](#deploy-contracts)
4. [`Register Resources Ethereum`](#register-resources-ethereum)
5. [`Specify Token Semantics`](#specify-token-semantics)
6. [`Register Relayers`](#register-relayers)
7. [`Register Resources Substrate`](#register-resources-substrate)
8. [`Whitelist Chains`](#whitelist-chains)
9. [`Run Relayer`](#run-relayer)
10. [`Fungible Transfers`](#fungible-transfers)
11. [`Non-Fungible Transfers`](#non-fungible-transfers)

## Start Local Chains

The easiest way to get started is to use the docker-compose file found [here](https://github.com/ChainSafe/ChainBridge/blob/main/docker-compose-e2e.yml). This will start two geth instances and an instance of chainbridge-substrate-chain:

```bash
docker compose -f docker-compose-e2e.yml up -V
```

(Use `-V` to always start with new chains. These instructions depend on deterministic Ethereum addresses, which are used as defaults implicitly by some of these commands. Avoid re-deploying the contracts without restarting both chains, or ensure to specify all the required parameters.)

## Connect to PolkadotJS Portal

1. Access the PolkadotJS Portal for Centrifuge, as an example Substrate chain, [here](https://portal.chain.centrifuge.io/)

2. Connect to your local Substrate chain:
    - Click the network in the top-left corner
    - Select the Development dropdown
    - Set `ws://localhost:9944` as the custom endpoint
    - Click `Switch` to connect

3. Set up type definitions for the chain:
    - Navigate to `Settings`
    - Select the `Developer` tab
    - Paste in the below Type Defintions
    - Save

**Type Defintions:**
```json
{
  "chainbridge::ChainId": "u8",
  "ChainId": "u8",
  "ResourceId": "[u8; 32]",
  "DepositNonce": "u64",
  "ProposalVotes": {
    "votes_for": "Vec<AccountId>",
    "votes_against": "Vec<AccountId>",
    "status": "enum"
  },
  "Erc721Token": {
    "id": "TokenId",
    "metadata": "Vec<u8>"
  },
  "TokenId": "U256",
  "Address": "AccountId",
  "LookupSource": "AccountId"
}
```
* These can be found found [here](https://github.com/ChainSafe/chainbridge-Substrate-chain#polkadot-js-apps)

## On-Chain Setup (Ethereum)

### Deploy Contracts

To deploy the contracts on to the Ethereum chain, run the following:

```bash
cb-sol-cli deploy --all --relayerThreshold 1
```

After running, the expected output looks like this:

```bash
================================================================
Url:        http://localhost:8545
Deployer:   0xff93B45308FD417dF303D6515aB04D9e89a750Ca
Gas Limit:   8000000
Gas Price:   20000000
Deploy Cost: 0.0

Options
=======
Chain Id:    0
Threshold:   1
Relayers:    0xff93B45308FD417dF303D6515aB04D9e89a750Ca,0x8e0a907331554AF72563Bd8D43051C2E64Be5d35,0x24962717f8fA5BA3b931bACaF9ac03924EB475a0,0x148FfB2074A9e59eD58142822b3eB3fcBffb0cd7,0x4CEEf6139f00F9F4535Ad19640Ff7A0137708485
Bridge Fee:  0
Expiry:      100

Contract Addresses
================================================================
Bridge:             0x62877dDCd49aD22f5eDfc6ac108e9a4b5D2bD88B
----------------------------------------------------------------
Erc20 Handler:      0x3167776db165D8eA0f51790CA2bbf44Db5105ADF
----------------------------------------------------------------
Erc721 Handler:     0x3f709398808af36ADBA86ACC617FeB7F5B7B193E
----------------------------------------------------------------
Generic Handler:    0x2B6Ab4b880A45a07d83Cf4d664Df4Ab85705Bc07
----------------------------------------------------------------
Erc20:              0x21605f71845f372A9ed84253d2D024B7B10999f4
----------------------------------------------------------------
Erc721:             0xd7E33e1bbf65dC001A0Eb1552613106CD7e40C31
----------------------------------------------------------------
Centrifuge Asset:   Not Deployed
----------------------------------------------------------------
WETC:               Not Deployed
================================================================
```

### Register Resources Ethereum

* **NOTE:** The below registrations will **not** notify you upon successful completion.

```bash
# Register fungible resource ID with erc20 contract
cb-sol-cli bridge register-resource --resourceId "0x000000000000000000000000000000c76ebe4a02bbc34786d860b355f5a5ce00" --targetContract "0x21605f71845f372A9ed84253d2D024B7B10999f4"

# Register non-fungible resource ID with erc721 contract
cb-sol-cli bridge register-resource --resourceId "0x000000000000000000000000000000e389d61c11e5fe32ec1735b3cd38c69501" --targetContract "0xd7E33e1bbf65dC001A0Eb1552613106CD7e40C31" --handler "0x3f709398808af36ADBA86ACC617FeB7F5B7B193E"

# Register generic resource ID
cb-sol-cli bridge register-generic-resource --resourceId "0x000000000000000000000000000000f44be64d2de895454c3467021928e55e01" --targetContract "0xc279648CE5cAa25B9bA753dAb0Dfef44A069BaF4" --handler "0x2B6Ab4b880A45a07d83Cf4d664Df4Ab85705Bc07" --hash --deposit "" --execute "store(bytes32)"
```

### Specify Token Semantics

To allow for a variety of use cases, the Ethereum contracts support both the `transfer` and the `mint/burn` ERC methods.

For simplicity's sake the following examples only make use of the  `mint/burn` method:

```bash
# Register the erc20 contract as mintable/burnable
cb-sol-cli bridge set-burn --tokenContract "0x21605f71845f372A9ed84253d2D024B7B10999f4"

# Register the associated handler as a minter
cb-sol-cli erc20 add-minter --minter "0x3167776db165D8eA0f51790CA2bbf44Db5105ADF"

# Register the erc721 contract as mintable/burnable
cb-sol-cli bridge set-burn --tokenContract "0xd7E33e1bbf65dC001A0Eb1552613106CD7e40C31" --handler "0x3f709398808af36ADBA86ACC617FeB7F5B7B193E"

# Add the handler as a minter
cb-sol-cli erc721 add-minter --minter "0x3f709398808af36ADBA86ACC617FeB7F5B7B193E"
```

## On-Chain Setup (Substrate)

### Register Relayers

First, we need to register the account of the relayer on Substrate (cb-sol-cli deploys contracts with the 5 test keys preloaded). 

Steps to register the relayers:
1. Select the `Sudo` tab in the PolkadotJS Portal
2. Choose the `addRelayer` method of `chainBridge`
3. Select **Alice** as the relayer `AccountId`

### Register Resources Substrate

Steps to register resources:
1. Select the `Sudo` tab in the PolkadotJS Portal
2. Call `chainBridge.setResource`, passing both the `Id` and `Method` listed below for each of the transfer types you wish to use

**Fungible (Native asset):**

Id: `0x000000000000000000000000000000c76ebe4a02bbc34786d860b355f5a5ce00`

Method: `0x4578616d706c652e7472616e73666572` (utf-8 encoding of "Example.transfer")

**NonFungible(ERC721):**

Id: `0x000000000000000000000000000000e389d61c11e5fe32ec1735b3cd38c69501`

Method: `0x4578616d706c652e6d696e745f657263373231` (utf-8 encoding of "Example.mint_erc721")

**Generic (Hash Transfer):**

Id: `0x000000000000000000000000000000f44be64d2de895454c3467021928e55e01`

Method:  `0x4578616d706c652e72656d61726b` (utf-8 encoding of "Example.remark")

### Whitelist Chains

Steps to whitelist chains:
1. Select the `Sudo` tab in the PolkadotJS Portal
2. Call `chainBridge.whitelistChain`, specifying `0` for the Ethereum chain ID

## Run Relayer

Steps to run a relayer:
1. Clone the [ChainBridge repository](https://github.com/ChainSafe/ChainBridge)
2. Install the ChainBridge binary
```zsh
cd ChainBridge && make install
```
- This will build ChainBridge and move it to your GOBIN path
3. Create `config.json` using the below as a sample template
4. Start relayer as a binary using the default "Alice" key
```zsh
chainbridge --config config.json --testkey alice --latest
```

OR

If you prefer Docker, steps 2 and 4 can be done as follows:

2. Build an image first
```zsh
docker build -t chainsafe/chainbridge .
```
4. Start the relayer as a docker container:
```zsh
docker run -v $(pwd)/config.json:/config.json --network host chainsafe/chainbridge --testkey alice --latest
```

Sample `config.json`:
```json
{
  "chains": [
    {
      "name": "eth",
      "type": "Ethereum",
      "id": "0",
      "endpoint": "ws://localhost:8545",
      "from": "0xff93B45308FD417dF303D6515aB04D9e89a750Ca",
      "opts": {
        "bridge": "0x62877dDCd49aD22f5eDfc6ac108e9a4b5D2bD88B",
        "erc20Handler": "0x3167776db165D8eA0f51790CA2bbf44Db5105ADF",
        "erc721Handler": "0x3f709398808af36ADBA86ACC617FeB7F5B7B193E",
        "genericHandler": "0x2B6Ab4b880A45a07d83Cf4d664Df4Ab85705Bc07",
        "gasLimit": "1000000",
        "maxGasPrice": "20000000"
      }
    },
    {
      "name": "sub",
      "type": "Substrate",
      "id": "1",
      "endpoint": "ws://localhost:9944",
      "from": "5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY",
      "opts": {}
    }
  ]
}
```
- This is an example config file for a single relayer ("Alice") using the contracts we've deployed.

## Fungible Transfers

### Substrate Native Token ⇒ ERC 20

Steps to transfer an ERC-20 token:
1. Select the `Extrinsics` tab in the PolkadotJS Portal
2. Call `example.transferNative` with parameters such as these:

- Amount: `1000` **(select `Pico` for units)**
- Recipient: `0xff93B45308FD417dF303D6515aB04D9e89a750Ca`
- Dest Id: `0`

You can query the recipients balance on Ethereum with this:

```bash
cb-sol-cli erc20 balance --address "0xff93B45308FD417dF303D6515aB04D9e89a750Ca"
```

### ERC20 ⇒ Substrate Native Token

If necessary, you can mint some tokens:

```bash
cb-sol-cli erc20 mint --amount 1000
```

Before initiating the transfer we have to approve the bridge to take ownership of the tokens:

```bash
cb-sol-cli erc20 approve --amount 1000 --recipient "0x3167776db165D8eA0f51790CA2bbf44Db5105ADF"
```

To initiate a transfer on the Ethereum chain use this command (Note: there will be a 10 block delay before the relayer will process the transfer):

```bash
cb-sol-cli erc20 deposit --amount 1 --dest 1 --recipient "0xd43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d" --resourceId "0x000000000000000000000000000000c76ebe4a02bbc34786d860b355f5a5ce00"
```

## Non-Fungible Transfers

### Substrate NFT ⇒ ERC721

First, you'll need to mint a token.

Steps to mint an ERC-721 token:
1. Select the `Sudo` tab in the PolkadotJS Portal
2. Call `erc721.mint` with parameters such as these:

- Owner: `Alice`
- TokenId: `1`
- Metadata: `""`

Now the owner of the token can initiate a transfer.

Steps to transfer an ERC-721 token:
1. Select the `Sudo` tab in the PolkadotJS Portal
2. Call `example.transferErc721` with parameters such as these:

- Recipient: `0xff93B45308FD417dF303D6515aB04D9e89a750Ca`
- TokenId: `1`
- DestId: `0`

You can query ownership of tokens on Ethereum with this:

```bash
cb-sol-cli erc721 owner --id 0x1
```

### ERC721 ⇒ Substrate NFT

If necessary, you can mint an ERC-721 token like this:

```bash
cb-sol-cli erc721 mint --id 0x99
```

Before initiating the transfer, we must approve the bridge to take ownership of the tokens:

```bash
cb-sol-cli erc721 approve --id 0x99 --recipient "0x3f709398808af36ADBA86ACC617FeB7F5B7B193E"
```

Now we can initiate the transfer:

```bash
cb-sol-cli erc721 deposit --id 0x99 --dest 1 --resourceId "0x000000000000000000000000000000e389d61c11e5fe32ec1735b3cd38c69501" --recipient "0xd43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d"
```

### Generic Data Transfer

To demonstrate a possible use of the generic data transfer, we have a hash registry on Ethereum. We also have a method on the example Substrate chain to emit a hash inside an event, which we can trigger from Ethereum. 

### Generic Data Substrate ⇒ Eth

For this example we will transfer a 32 byte hash to a registry on Ethereum. 

Steps to transfer data to Ethereum:
1. Select the `Extrinsics` tab in the PolkadotJS Portal
2. Call `example.transferHash` with parameters such as these:

- Hash: `0x699c776c7e6ce8e6d96d979b60e41135a13a2303ae1610c8d546f31f0c6dc730`
- Dest ID: `0`

You can verify the transfer with this command:

```bash
cb-sol-cli cent getHash --hash 0x699c776c7e6ce8e6d96d979b60e41135a13a2303ae1610c8d546f31f0c6dc730
```
