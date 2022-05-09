# lighthouse-shadowfork

A docker-compose setup for running lighthouse with different execution clients on testing shadow forks.

## How to use

Clone the repository along with submodules for latest testnets:
```
git clone --recurse-submodules https://github.com/ethDreamer/lighthouse-shadowfork.git
```

#### Set Variables in `globals.sh`

- `ETH2_TESTNET`   # the name of the testnet directory to use (see `./shared/merge-testnets`)
- `EXECUTION_NODE` # pick between `geth`, `besu`, or `nethermind`
- `CONSENSUS_DISC` # the discovery port (TCP/UDP) for lighthouse (should be accessible from internet)
- `EXECUTION_DISC` # the discovery port (TCP/UDP) for execution node (should be accessible from internet)
- `EXPLORER_PORT`  # port to serve the front-end for the beacon explorer

After editing these be sure to run:
```
source ./globals.sh
```

#### Start the nodes

There are two yaml files:
- `ethereum.yaml` # runs without beacon explorer
- `with-explorer.yaml` # runs with beacon explorer

Regardless of which one you want you use, it's best to start the explorer after you've synced the consensus/execution nodes. So start up without the explorer first:

```
docker-compose -f ethereum.yaml up -d
```

That should start all the services. You can view running containers with `docker container ls`. You can view container logs with `docker logs -f <CONTAINER ID>`. Once the nodes are synced, you can bring them down with:

```
docker-compose -f ethereum.yaml down
```

and then start everything (including the beacon explorer) with:
```
docker-compose -f with-explorer up -d
```

The beacon explorer front end will be accessible at `http://$HOSTNAME:$EXPLORER_PORT`




