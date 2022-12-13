#!/bin/bash

TESTNETDIR=/shared/${TESTNET_REPO}/${ETH2_TESTNET}

BOOTFILE=${TESTNETDIR}/el_bootnode.txt
if [ -e $BOOTFILE ]; then
	BOOTARG="--Network.Bootnodes=$(cat $BOOTFILE | tr '\n' ',' | sed 's/,\s*$//')"
fi

GENFILE=${TESTNETDIR}/nethermind_genesis.json
if [ -e $GENFILE ]; then
	GENARG="--Init.ChainSpecPath=$GENFILE"
fi

ETH2CONFIG=${TESTNETDIR}/config.yaml
TTD=$(cat $ETH2CONFIG 2>/dev/null | grep TERMINAL_TOTAL_DIFFICULTY | awk '{ print $2 }')
if [ -n "$TTD" ]; then
    TTDARG="--Merge.TerminalTotalDifficulty=$TTD"
fi

echo "******************** STARTING NETHERMIND ********************"

exec /nethermind/Nethermind.Runner \
    --config=mainnet_shadowfork \
    --datadir="./datadir" \
    $GENARG \
	--JsonRpc.Enabled=true \
	--JsonRpc.EnabledModules="net,eth,consensus,subscribe,web3,admin" \
	--JsonRpc.Port=8545 \
	--JsonRpc.Host=0.0.0.0 \
	--Network.DiscoveryPort=30303 \
	--Network.P2PPort=30303 \
	--Merge.Enabled=true \
    --JsonRpc.JwtSecretFile=/shared/jwt.secret \
    --JsonRpc.AdditionalRpcUrls="http://0.0.0.0:8560|http;ws|net;eth;subscribe;engine;web3;client" \
    $BOOTARG \
    $TTDARG



#    --logging=INFO \
#    --host-allowlist="*" \
#    --rpc-http-cors-origins="*" \
#    --rpc-http-api="ADMIN,ETH,NET,DEBUG,TXPOOL" \
#    --p2p-enabled=true \
#    --sync-mode=FAST \
#    --Xmerge-support=true \
#    --data-storage-format="BONSAI" \
#    --rpc-http-host=0.0.0.0 \
#    --engine-host-allowlist="*" \
#    --engine-jwt-enabled=true \
#    --engine-jwt-secret=/shared/jwt.secret \
#    --engine-rpc-http-port=8560 \

