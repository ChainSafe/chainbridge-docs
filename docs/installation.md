# Installation

Before anything further can be done, we need to download some necessary software.

## ChainBridge Binary

_In this step, we will build the ChainBridge-Core-Example binary._

_This binary will function as the bridge remote control, so-to-speak, and is designed to showcase compatibility of our core bridge code alongside network-specific modules._

For this example, the binary includes the following components: 1. **Core:** general code necessary to operating the bridge 2. **Celo-Module:** the Celo-specific code 3. **EVM-Module:** the EVM-specific code

_If you wish to bridge different networks other than the example provided, simply clone the_ [_ChainBridge-Core-Example repository_](https://github.com/ChainSafe/chainbridge-core-example.git)_, checkout one of the other pre-configured branches \(e.g. evm-evm, evm-substrate\), and then follow the instructions provided in the `Makefile` to install the binary._

### Clone Repository

_Navigate to the ChainBridge-Core-Example repo in GitHub and clone it._

```bash
git clone https://github.com/ChainSafe/chainbridge-core-example.git
```

### Checkout Pre-configured Branch

_Now we will `cd` into the chainbridge-core-example repo and checkout a pre-configured branch for the networks we are wishing to bridge._

#### Since we are bridging Celo and Ethereum, we will use the `celo-evm-dev` branch.

```bash
cd chainbridge-core-example && git checkout celo-evm-dev
```

### Build Binary

_Once the branch is checked out, we will build the binary from the source._

```bash
make build
```

### Run Binary

_To ensure everything downloaded correctly and will work on your system, try executing the ChainBridge-Core-Example binary and print the help instructions._

```bash
./chainbridge-core-example -h
```

### Output

_Below is a proper output of the CLI help screen._

```bash
Usage:
   [command]

Available Commands:
  celo-cli    Celo CLI
  completion  generate the autocompletion script for the specified shell
  evm-cli     EVM CLI
  help        Help about any command
  run         Run example app

Flags:
  -h, --help   help for this command

Use " [command] --help" for more information about a command.
```

#### If any part of the installation fails or if the instructions are unclear, feel free to reach out to us directly via our shared Slack channel for assistance.

