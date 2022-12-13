#!/bin/bash

TESTNETDIR=/shared/${TESTNET_REPO}/${ETH2_TESTNET}

BOOTFILE=${TESTNETDIR}/el_bootnode.txt
if [ -e $BOOTFILE ]; then
	BOOT_ARG="--bootnodes=$(cat $BOOTFILE | tr '\n' ',' | sed 's/,\s*$//')"
fi

GENFILE=${TESTNETDIR}/genesis.json
if [ -e $GENFILE ]; then
    NET_ARG="--network-id=$(cat $GENFILE | grep chainId | awk '{ print $2 }' | sed 's/,//g')"
    GEN_ARG="--genesis-file=$GENFILE"
fi

if [ ! -z "$METRICS_ENABLED" ]; then
    METRICS_ARG="--metrics-enabled --metrics-host=0.0.0.0 --metrics-port 6060"
fi

export WANIP=$(dig +short myip.opendns.com @resolver1.opendns.com)

echo "******************** STARTING BESU ********************"
echo "WAN IP: $WANIP"

exec besu \
    --data-path="./datadir" \
    --rpc-http-enabled=true \
    --logging=INFO \
    --host-allowlist="*" \
    $METRICS_ARG \
    --rpc-http-cors-origins="*" \
    --rpc-http-host=0.0.0.0 \
    --data-storage-format="BONSAI" \
    --rpc-http-api="ADMIN,ETH,NET,DEBUG,TXPOOL" \
    --p2p-enabled=true \
    --p2p-host=$WANIP \
    --p2p-port=$EXECUTION_DISC \
    --nat-method=DOCKER \
    --sync-mode=X_SNAP \
    --engine-rpc-enabled \
    --engine-host-allowlist="*" \
    --engine-jwt-enabled=true \
    --engine-jwt-secret=/shared/jwt.secret \
    --engine-rpc-port=8560 \
    $BOOT_ARG \
    $NET_ARG \
    $GEN_ARG

