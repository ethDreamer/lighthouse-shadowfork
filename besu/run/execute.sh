#!/bin/sh

TESTNETDIR=/shared/merge-testnets/${ETH2_TESTNET}

BOOTFILE=${TESTNETDIR}/el_bootnode.txt
if [ -e $BOOTFILE ]; then
	BOOT_ARG="--bootnodes=$(cat $BOOTFILE | tr '\n' ',' | sed 's/,\s*$//')"
fi

GENFILE=${TESTNETDIR}/genesis.json
if [ -e $GENFILE ]; then
    NET_ARG="--network-id=$(cat $GENFILE | grep chainId | awk '{ print $2 }' | sed 's/,//g')"
    GEN_ARG="--genesis-file=$GENFILE"
fi

ETH2CONFIG=${TESTNETDIR}/config.yaml
TTD=$(cat $ETH2CONFIG | grep TERMINAL_TOTAL_DIFFICULTY | awk '{ print $2 }')
if [ -n "$TTD" ]; then
    TTD_ARG="--override.terminaltotaldifficulty=$TTD"
fi

if [ ! -z "$METRICS_ENABLED" ]; then
    METRICS_ARG="--metrics-enabled --metrics-host=0.0.0.0 --metrics-port 6060"
fi

echo "******************** STARTING BESU ********************"

exec besu \
    --data-path="./datadir" \
    --rpc-http-enabled=true \
    --logging=INFO \
    --host-allowlist="*" \
    --rpc-http-cors-origins="*" \
    --rpc-http-api="ADMIN,ETH,NET,DEBUG,TXPOOL" \
    --p2p-enabled=true \
    --sync-mode=FAST \
    --Xmerge-support=true \
    --data-storage-format="BONSAI" \
    --rpc-http-host=0.0.0.0 \
    --engine-rpc-enabled \
    --engine-host-allowlist="*" \
    --engine-jwt-enabled=true \
    --engine-jwt-secret=/shared/jwt.secret \
    --engine-rpc-port=8560 \
    $METRICS_ARG \
    $BOOT_ARG \
    $NET_ARG \
    $GEN_ARG

