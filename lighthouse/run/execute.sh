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


BOOTFILE=/shared/${TESTNET_REPO}/${ETH2_TESTNET}/inventory/group_vars/all.yaml
if [ -e $BOOTFILE ]; then
    BOOT_ARG="--boot-nodes=$(cat $BOOTFILE | grep -A5 bootnode_enrs | grep 'enr:' | awk '{ print $2 }' | sed 's/"//g' | tr '\n' ',' | sed 's/,$//')"
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

exec lighthouse \
    --debug-level=debug \
    --datadir ./datadir \
    --testnet-dir=/shared/${TESTNET_REPO}/$ETH2_TESTNET/custom_config_data \
    beacon \
    --eth1 \
    $BOOT_ARG \
    $STATIC_PEERS \
    --http \
    --enr-address=$(dig +short myip.opendns.com @resolver1.opendns.com) \
    --enr-udp-port=$CONSENSUS_DISC \
    --enr-tcp-port=$CONSENSUS_DISC \
    --port $CONSENSUS_DISC \
    --http-address=0.0.0.0 \
    $(printf '%s' "$METRICS_ARG") \
    --http-allow-sync-stalled \
    --disable-packet-filter \
    --jwt-secrets=/shared/jwt.secret \
    --execution-endpoints=$EE_TARGET \
    $RELAY_ARG

