#!/bin/bash

varset() {
	# accepts array of variable names and returns true if all are set
    for i in $@; do
        if [ -z ${!i+x} ]; then
            return 1
        fi
    done
    return 0
}

if $(varset VALIDATOR_MNEMONIC) || $(varset VALIDATOR_COUNT) ; then
	if ! $(varset VALIDATOR_MNEMONIC VALIDATOR_COUNT) ; then
		# ensure all these are set if any of them are
		echo "Error: must set BOTH VALIDATOR_MNEMONIC and VALIDATOR_COUNT"
        exit 1
	fi
    exec ./validator.sh
fi

# No VALIDATOR_* vars set -> run beacon node

BOOTFILE=/shared/merge-testnets/${ETH2_TESTNET}/bootstrap_nodes.txt
if [ -e $BOOTFILE ]; then
    BOOT_ARG="--boot-nodes=$(cat $BOOTFILE | tr '\n' ',' | sed 's/,\s*$//')"
fi

if [ "$METRICS_ENABLED" = "true" ]; then
    METRICS_ARG="--metrics --metrics-address=0.0.0.0 --metrics-allow-origin=*"
fi

if [ "$PROXY_ENABLED" = "true" ]; then
    EE_TARGET="http://proxy:8560"
else
    EE_TARGET="http://execution:8560"
fi


if [ "$RELAY_ENABLED" = "true" ]; then
    RELAY_ARG="--builder=http://relay-proxy:8560"
fi
if [ "$MEVBOOST_ENABLED" = "true" ]; then
    RELAY_ARG="--builder=http://boost-proxy:8560"
fi


echo "******************** STARTING LIGHTHOUSE BEACON NODE ********************"

if [ -e ./lighthouse.bin ]; then
    LIGHTHOUSE=./lighthouse.bin
else
    LIGHTHOUSE=lighthouse
fi

exec $LIGHTHOUSE \
    --debug-level=info \
    --datadir ./datadir \
    --testnet-dir=/shared/merge-testnets/$ETH2_TESTNET \
    beacon \
    --disable-enr-auto-update \
    --eth1 \
    $BOOT_ARG \
    --http \
    --http-address=0.0.0.0 \
    $(printf '%s' "$METRICS_ARG") \
    --http-allow-sync-stalled \
    --merge \
    --eth1-endpoints=http://execution:8545 \
    --disable-packet-filter \
    --jwt-secrets=/shared/jwt.secret \
    --execution-endpoints=$EE_TARGET \
    $RELAY_ARG

