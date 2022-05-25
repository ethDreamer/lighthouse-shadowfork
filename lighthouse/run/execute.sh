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
    BOOTARG="--boot-nodes=$(cat $BOOTFILE | tr '\n' ',' | sed 's/,\s*$//')"
fi

echo "******************** STARTING LIGHTHOUSE BEACON NODE ********************"

exec lighthouse \
    --debug-level=info \
    --datadir ./datadir \
    --testnet-dir=/shared/merge-testnets/$ETH2_TESTNET \
    beacon \
    --disable-enr-auto-update \
    --eth1 \
    $BOOTARG \
    --http \
    --http-address=0.0.0.0 \
    --metrics \
    --metrics-address=0.0.0.0 \
    --metrics-allow-origin \* \
    --validator-monitor-auto \
    --http-allow-sync-stalled \
    --merge \
    --disable-packet-filter \
    --jwt-secrets=/shared/jwt.secret \
    --execution-endpoints=http://proxy:8560 \
    --eth1-endpoints=http://execution:8545

