# lighthouse-shadowfork

A docker-compose setup for running lighthouse with different execution clients on testing shadow forks.

## How to use

Clone the repository along with submodules for latest testnets:
```
git clone --recurse-submodules https://github.com/ethDreamer/lighthouse-shadowfork.git
```

Ensure you have the latest copy of merge-testnets:
```
cd lighthouse-shadowfork && git submodule update --remote
```

#### Set Variables in `globals.sh`

- `ETH2_TESTNET`   # the name of the testnet directory to use (see `./shared/merge-testnets`)
- `EXECUTION_NODE` # pick between `geth`, `besu`, or `nethermind`
- `CONSENSUS_DISC` # the discovery port (TCP/UDP) for lighthouse (should be accessible from internet)
- `EXECUTION_DISC` # the discovery port (TCP/UDP) for execution node (should be accessible from internet)
- `EXPLORER_PORT`  # port to serve the front-end for the beacon explorer
- `PROMETHEUS_PORT`    # port to serve the prometheus front-end
- `GRAFANA_PORT`       # port to serve the grafana front-end

#### Validator Options if you have validators on the testnet
- `VALIDATOR_MNEMONIC` # set this to the mnemonic to generate validators
- `VALIDATOR_COUNT`    # the number of validators on the mnemonic
- `VALIDATOR_GRAFFITI` # set your validator graffiti (must be <= 32 characters)
- `FEE_RECIPIENT`      # set address of the fee recipient

After editing these be sure to run:
```
source ./globals.sh
```

#### Start the nodes

To enable only essential services (consensus/execution/proxy nodes), simply run:
```
docker-compose up -d
```

The docker-compose file includes profiles that can be used to start additional optional services. These profiles include:
- `validator`: start up a validator client
- `metrics`: start up a prometheus/grafana server and gather metrics on the nodes
- `explorer`: start up a beacon chain explorer (recommend this only be started after nodes fully sync)

Any of these services can be included by passing `--profile` on the command line to docker-compose. For example, to start the validator client and track metrics run:
```
docker-compose --profile validator --profile metrics up -d
```

Currently running containers can be viewed with `docker container ls`. Container logs can be viewed with `docker logs -f <CONTAINER ID>`. To stop all containers, simply run
```
docker-compose down
```

If run with the `explorer` profile, the beacon explorer front end will be accessible at `http://$HOSTNAME:$EXPLORER_PORT`. Similarly, if run with the `metrics` profile, the prometheus front-end will be accessible at `http://$HOSTNAME:$PROMETHEUS_PORT` and grafana will be accessible at `http://$HOSTNAME:$GRAFANA_PORT`.


