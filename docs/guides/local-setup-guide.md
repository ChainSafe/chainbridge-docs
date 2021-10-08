# Local Setup Guide

In this guide, we're going to walk through the details of setting up the [chainbridge-core-example](https://github.com/chainsafe/chainbridge-core-example) in order to showcase the [chainbridge-core](https://github.com/chainsafe/chainbridge-core) library.

1. [Overview](#overview)
2. [Installation](#installation)
3. [Local Customization](#local-customization)
3. [Usage](#usage)
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
## Usage
Now that we have properly installed the [chainbridge-core-example](https://github.com/chainsafe/chainbridge-core-example) and have seen how to customize its module sourcing for our local development needs, we can now use the CLI for either issuing commands to the networks we are seeking to bridge, or by running the software as a bridge relayer if the contracts are already deployed.

The following resources can be referenced for further explanation in either of these areas.

[Deployment Guide](deployment-guide.md)

[CLI Commands](https://github.com/ChainSafe/chainbridge-core/blob/main/README.md)

