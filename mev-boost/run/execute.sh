#!/bin/sh

RELAY="https://0xafa4c6985aa049fb79dd37010438cfebeb0f2bd42b115b89dd678dab0670c1de38da0c4e9138c9290a398ecd9a0b3110@builder-relay-goerli-sf5.flashbots.net"

/app/mev-boost \
    -addr 0.0.0.0:8560 \
    -loglevel info \
    -goerli-shadow-fork-5 \
    -relays $RELAY

