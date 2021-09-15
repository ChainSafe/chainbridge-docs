# Installation

## Installation[¶](installation.md#installation) <a id="installation"></a>

### Dependencies[¶](installation.md#dependencies) <a id="dependencies"></a>

* [Subkey](https://github.com/paritytech/substrate): Used for substrate key management. Only required if connecting to a substrate chain.

```text
make install-subkey
```

### Building from Source[¶](installation.md#building-from-source) <a id="building-from-source"></a>

To build `chainbridge` in `./build`.

```text
make build
```

**or**

Use`go install` to add `chainbridge` to your GOBIN.

```text
make install
```

### Docker[¶](installation.md#docker) <a id="docker"></a>

The official ChainBridge Docker image can be found [here](https://hub.docker.com/r/chainsafe/chainbridge).

To build the Docker image locally run:

```text
docker build -t chainsafe/chainbridge .
```

To start ChainBridge:

```text
docker run -v $(pwd)/config.json:/config.json chainsafe/chainbridge
```

