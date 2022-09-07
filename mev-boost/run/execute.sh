#!/bin/sh

PUBKEY="0xaaa017c9b1bb6449c88a124412ea370b0225fce98d29885cd72dac2c32cfa86fadad502984b3422c894f977479221af5"
RELAY="https://0xafa4c6985aa049fb79dd37010438cfebeb0f2bd42b115b89dd678dab0670c1de38da0c4e9138c9290a398ecd9a0b3110@builder-relay-goerli-sf5.flashbots.net"

GENESIS_FORK_VERSION=$(cat /shared/merge-testnets/${ETH2_TESTNET}/config.yaml | grep GENESIS_FORK_VERSION | sed 's/.*: //')
FORK_ARG="-genesis-fork-version $GENESIS_FORK_VERSION"

if [ "$MOCK_PROXY_ENABLED" = "true" ]; then
    RELAY=http://$PUBKEY@mock-proxy:8560
fi

echo "******************** STARTING MEV-BOOST ********************"

/app/mev-boost \
    -addr 0.0.0.0:8560 \
    -loglevel info \
    $FORK_ARG \
    -relays $RELAY

