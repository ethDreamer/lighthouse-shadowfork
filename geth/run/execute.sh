#!/bin/sh

TESTNETDIR=/shared/${TESTNET_REPO}/${ETH2_TESTNET}

BOOTFILE=${TESTNETDIR}/inventory/group_vars/all.yaml
if [ -e $BOOTFILE ]; then
	BOOT_ARG="--bootnodes=$(cat $BOOTFILE | grep -A5 el_bootnode | grep "enode://" | awk '{ print $2 }' | sort | uniq | sed 's/"//g' | tr '\n' ',' | sed 's/,\s*$//')"
fi

GENFILE=${TESTNETDIR}/custom_config_data/genesis.json
if [ -e $GENFILE ]; then
    NET_ARG="--networkid=$(cat $GENFILE | grep chainId | awk '{ print $2 }' | sed 's/,//g')"
    if [ ! -e ./datadir ]; then
        echo "**** INITIALIZING DATADIR FROM GENESIS FILE ****"
        echo "$GENFILE"
        geth --datadir ./datadir init $GENFILE
        echo "**** INITIALIZING DATADIR FROM GENESIS FILE ****"
    fi
fi

ETH2CONFIG=${TESTNETDIR}/custom_config_data/config.yaml
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
    --port $EXECUTION_DISC \
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
