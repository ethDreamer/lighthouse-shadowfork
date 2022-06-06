#!/bin/sh

TESTNETDIR=/shared/merge-testnets/${ETH2_TESTNET}

BOOTFILE=${TESTNETDIR}/el_bootnode.txt
if [ -e $BOOTFILE ]; then
	BOOT_ARG="--bootnodes=$(cat $BOOTFILE | sed 's/\s\+//g' | tr '\n' ',' | sed 's/,\s*$//')"
fi

GENFILE=${TESTNETDIR}/genesis.json
if [ -e $GENFILE ]; then
    NET_ARG="--networkid=$(cat $GENFILE | grep chainId | awk '{ print $2 }' | sed 's/,//g')"
    if [ ! -e ./datadir ]; then
        echo "**** INITIALIZING DATADIR FROM GENESIS FILE ****"
        echo "$GENFILE"
        echo "**** INITIALIZING DATADIR FROM GENESIS FILE ****"
        geth init $GENFILE  --datadir ./datadir
    fi
fi

ETH2CONFIG=${TESTNETDIR}/config.yaml
TTD=$(cat $ETH2CONFIG | grep TERMINAL_TOTAL_DIFFICULTY | awk '{ print $2 }')
if [ -n "$TTD" ]; then
    TTD_ARG="--override.terminaltotaldifficulty=$TTD"
fi

if [ ! -z "$METRICS_ENABLED" ]; then
    METRICS_ARG="--metrics --metrics.addr=0.0.0.0"
fi

echo "******************** STARTING GETH ********************"


exec geth \
    --datadir ./datadir \
    --http \
    --http.addr 0.0.0.0 \
    --http.api="engine,eth,web3,net,debug,admin" \
    --http.vhosts=\* \
    --port 30303 \
    $NET_ARG \
    $BOOT_ARG \
    --syncmode snap \
    --verbosity=3 \
    --authrpc.addr 0.0.0.0 \
    --authrpc.port 8560 \
    --authrpc.vhosts \* \
    --authrpc.jwtsecret=/shared/jwt.secret \
    $METRICS_ARG \
    $TTD_ARG


#    --nodiscover \
