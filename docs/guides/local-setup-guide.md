# Local Setup Guide

In this guide, we're going to walk through the details of setting up the [chainbridge-core-example](https://github.com/chainsafe/chainbridge-core-example) in order to showcase the [chainbridge-core](https://github.com/chainsafe/chainbridge-core) library.

### Table of Contents

1. [Overview](#overview)
2. [Installation](#installation)
3. [Local Customization](#local-customization)
4. [Setup Local Development Chains](#setup-local-developent-chains)
5. [Configuration](#configuration)
6. [Usage](#usage)
#
## Overview
##### *borrowed from repository README 
&nbsp;  
The [chainbridge-core](https://github.com/chainsafe/chainbridge-core) is the project that was born from the existing version of Chainbridge. It was built to improve the maintainability and modularity of the current solution. The fundamental distinction is that chainbridge-core is more of a framework rather than a stand-alone application.

In other words, it's a library, and therefore contains no `main.go` file. Therefore, we need some sort of example that will allow us to source files and packages from the [chainbridge-core](https://github.com/chainsafe/chainbridge-core) library.

For this case, we have created the [chainbridge-core-example](https://github.com/chainsafe/chainbridge-core-example). 

As the name suggests, this is an example application (CLI) that serves **two** purposes: 
1. [It allows us to issue commands to our ChainBridge contracts](../transfer-and-balances.md)
2. [It serves the unique distinction as a bridge relayer](../relayers.md)

&nbsp;
## Installation

Before anything further can be done, we need to download and install some necessary software.

[Installation](../installation.md)

&nbsp; 
## Local Customization
The above section helps you to install the [chainbridge-core-example](https://github.com/chainsafe/chainbridge-core-example) which internally sources the [chainbridge-core](https://github.com/chainsafe/chainbridge-core) but it makes no mention how to assist with local development efforts.

Say we have are working on parts of the [chainbridge-core](https://github.com/chainsafe/chainbridge-core) and wish to test functionality (outside of unit/integration tests) by building the CLI with our local changes. This can easily be made possible by adding a single line to our `go.mod` within the [chainbridge-core-example](https://github.com/chainsafe/chainbridge-core-example).
&nbsp; 
```go
module github.com/ChainSafe/chainbridge-core-example

go 1.16

// replace existing version with local
replace github.com/ChainSafe/chainbridge-core => ../chainbridge-core

// the same can be done when working with various ChainBridge modules
replace github.com/ChainSafe/chainbridge-celo-module => ../chainbridge-celo-module

require (
    github.com/ChainSafe/chainbridge-core v0.0.0-20210922142450-7e66fa42a68e
    github.com/ChainSafe/chainbridge-celo-module v0.0.0-20210812101441-b6d7ad422a53
    ...
)
```

&nbsp; 

## Setup Local Development Chains
In this step we will start one geth instance and an instance of chainbridge-bootstrapped-celo. 

We chose these two networks because during the installation section we checked out the `evm-celo-dev` branch. 

Therefore, the assumption is we will be bridging the Ethereum and Celo networks.

```bash
docker-compose -f ./docker-compose.local.yml up -V
```

`docker-compose.local.yml`
```docker
# Copyright 2020 ChainSafe Systems
# SPDX-License-Identifier: LGPL-3.0-only
version: '3'

services:
  celo:
    image: "chainsafe/chainbridge-bootstrapped-celo:v1.0.0"
    container_name: celo
    ports:
      - "8546:8545"
  
  geth:
    image: "chainsafe/chainbridge-geth:20200505131100-5586a65"
    container_name: geth
    ports:
      - "8545:8545"
```

## Configuration
Within the [chainbridge-core-example config directory](https://github.com/ChainSafe/chainbridge-core-example/blob/evm-celo-dev/config) of the `evm-celo-dev` branch you will find **two** JSON configuration files. Both of these will require some slight customizations since likely the `from`, `bridge`, `erc20Handler` and `endpoint` fields will need to be updated to your own local needs.

`config_celo.json`
```json
{
  "name": "celo",
  "id": "0",
  "endpoint": "ws://localhost:8546",
  "from": "",
  "bridge": "",
  "erc20Handler": "",
  "gasLimit": "9000000",
  "maxGasPrice": "20000000000",
  "blockConfirmations": "10"
}
```

`config_evm.json`
```json
{
  "name": "ethereum",
  "id": "1",
  "endpoint": "ws://localhost:8545",
  "from": "",
  "bridge": "",
  "erc20Handler": "",
  "gasLimit": "9000000",
  "maxGasPrice": "20000000000",
  "blockConfirmations": "10"
}
```

#### NOTE: You will notice that the `id` field within both configs is different- this is a requirement; both chains must not share the same `id`!

&nbsp; 
## Usage
Now that we have properly installed the [chainbridge-core-example](https://github.com/chainsafe/chainbridge-core-example), have seen how to customize its module sourcing for our local development needs as well as have some local networks running, we can now use the CLI for either issuing commands to the networks we are seeking to bridge, or by running the software as a bridge relayer if the contracts are already deployed.

&nbsp; 
### Running a bridge relayer
This step describes how to use the [chainbridge-core-example](https://github.com/chainsafe/chainbridge-core-example) CLI we previously configured in order to serve as a relayer for the networks we are seeking to bridge.


**Notable flags**_

`--config`: Path to JSON configuration files directory (default ".")

`--testkey`: Applies a predetermined test keystore to the chain

`--fresh`: Disables loading from blockstore at start. Opts will still be used if specified. (default: false)

```bash
./chainbridge-core-example run --config /path/to/your/config/directory --testkey alice --fresh 
```

The following resources can be referenced for further explanation in either of these areas.

[Deployment Guide](deployment-guide.md)

[CLI Commands](https://github.com/ChainSafe/chainbridge-core/blob/main/README.md)

