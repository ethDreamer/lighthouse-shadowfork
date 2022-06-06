#!/bin/bash

export ETH2_TESTNET=mainnet-shadow-fork-1
export CONSENSUS_NODE=lighthouse # don't change this as there is no other option
export EXECUTION_NODE=besu # can be [geth|besu|nethermind]
export CONSENSUS_DISC=9002  # discovery TCP/UDP port open to internet for lighthouse
export EXECUTION_DISC=30305 # discovery TCP/UDP port open to internet for execution node

# set these if you have validators on the testnet
export VALIDATOR_MNEMONIC=""
export VALIDATOR_COUNT=0
export VALIDATOR_GRAFFITI="${CONSENSUS_NODE}-${EXECUTION_NODE} (@ethDreamer)"
export FEE_RECIPIENT="aba1e73b3c0908150fa5d1c4b6e8e8a839da7c6c"

# metrics settings
export PROMETHEUS_PORT=9090 # port to serve prometheus front-end
export GRAFANA_PORT=3000    # port to serve grafana front-end

export POSTGRES_PASSWORD=pass
export POSTGRES_USER=pguser
export POSTGRES_DB=db
export EXPLORER_PORT=3333 # the port to serve the front-end for the beacon explorer

mkdir -p explorer/run/postgres/db

# These are unused below
# lighthouse
export SIGP_REPO=https://github.com/sigp/lighthouse.git
export SIGP_BRANCH=unstable
# geth
export GETH_REPO=https://github.com/ethereum/go-ethereum.git
export GETH_BRANCH=master
# proxy
export PROXY_REPO=https://github.com/ethDreamer/json_rpc_snoop.git
export PROXY_BRANCH=master
# explorer
export EXPLORER_REPO=https://github.com/protolambda/eth2-beaconchain-explorer.git
export EXPLORER_BRANCH=rebasing-from-master



