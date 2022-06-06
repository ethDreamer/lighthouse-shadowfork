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

To enable only the base (consensus/execution/validator) nodes, simply run:
```
docker-compose -f ethereum.yml up -d
```

This repo contains configurations to enable additional services:
- `metrics.yml`: enables collecting metrics and spins up prometheus/grafana
- `proxy.yml`: spin up JSON-RPC proxy for debugging communication between consensus/execution layer
- `explorer.yml`: spins up beaconchain explorer and postgres db

Any of these services can be included by passing `-f [YAML_FILE]` after `ethereum.yml` on the command line to docker-compose. For example, to start JSON-RPC proxy and track metrics run:
```
docker-compose -f ethereum.yml -f proxy.yml -f metrics.yml up -d
```

Currently running containers can be viewed with `docker container ls`. Container logs can be viewed with `docker logs -f <CONTAINER ID>`. To stop all containers, run the same options used to bring up the services but replace `up -d` with `down`. For example, to stop all the services started above run:
```
docker-compose -f ethereum.yml -f proxy.yml -f metrics.yml down
```

If the beacon explorer is enabled, the front end will be accessible at `http://$HOSTNAME:$EXPLORER_PORT`. Similarly, if metrics are enabled, the prometheus front-end will be accessible at `http://$HOSTNAME:$PROMETHEUS_PORT` and grafana will be accessible at `http://$HOSTNAME:$GRAFANA_PORT`.


