#!/bin/sh

TESTNETDIR=/shared/merge-testnets/${ETH2_TESTNET}

BOOTFILE=${TESTNETDIR}/el_bootnode.txt
if [ -e $BOOTFILE ]; then
	BOOTARG="--bootnodes=$(cat $BOOTFILE | tr '\n' ',' | sed 's/,\s*$//')"
fi

GENFILE=${TESTNETDIR}/genesis.json
if [ -e $GENFILE ]; then
    NETARG="--network-id=$(cat $GENFILE | grep chainId | awk '{ print $2 }' | sed 's/,//g')"
	GENARG="--genesis-file=$GENFILE"
#    if [ ! -e ./datadir ]; then
#        echo "**** INITIALIZING DATADIR FROM GENESIS FILE ****"
#        echo "$GENFILE"
#        echo "**** INITIALIZING DATADIR FROM GENESIS FILE ****"
#        geth init $GENFILE  --datadir ./datadir
#    fi
fi

ETH2CONFIG=${TESTNETDIR}/config.yaml
TTD=$(cat $ETH2CONFIG | grep TERMINAL_TOTAL_DIFFICULTY | awk '{ print $2 }')
if [ -n "$TTD" ]; then
    TTDARG="--override.terminaltotaldifficulty=$TTD"
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
    --engine-host-allowlist="*" \
    --engine-jwt-enabled=true \
    --engine-jwt-secret=/shared/jwt.secret \
    --engine-rpc-http-port=8560 \
    --metrics-enabled \
    --metrics-host=0.0.0.0 \
    --metrics-port 6060 \
    $BOOTARG \
    $NETARG \
    $GENARG

