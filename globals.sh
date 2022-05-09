#!/bin/bash

export ETH2_TESTNET=mainnet-shadow-fork-1
export CONSENSUS_NODE=lighthouse
export EXECUTION_NODE=besu
export CONSENSUS_DISC=9002
export EXECUTION_DISC=30305

export VALIDATOR_MNEMONIC=""
export VALIDATOR_COUNT=0
export VALIDATOR_GRAFFITI="${CONSENSUS_NODE}-${EXECUTION_NODE} (@ethDreamer)"
export FEE_RECIPIENT="aba1e73b3c0908150fa5d1c4b6e8e8a839da7c6c"

export POSTGRES_PASSWORD=pass
export POSTGRES_USER=pguser
export POSTGRES_DB=db
export EXPLORER_PORT=3333

# testnet
export TESTNETS_REPO=https://github.com/eth-clients/merge-testnets.git
export TESTNETS_BRANCH=main
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
#export EXPLORER_REPO=https://github.com/gobitfly/eth2-beaconchain-explorer.git
#export EXPLORER_BRANCH=master




