# CLI Options

## Flags

### Global

#### `chainbridge-core-example evm-cli accounts generate`

```
--blockstore string   Specify path for blockstore (default "./lvldbdata")
--config string       Path to JSON configuration files directory (default ".")
--fresh               Disables loading from blockstore at start. Opts will still be used if specified. (default: false)
-h, --help                help for run
--keystore string     Path to keystore directory (default "./keys")
--latest              Overrides blockstore and start block, starts from latest block (default: false)
--testkey string      Applies a predetermined test keystore to the chains.
```

### Run Relayer

The `run` command is used to run the ChainBridge relayer.

_example_
```bash
./chainbridge-core-example 
```