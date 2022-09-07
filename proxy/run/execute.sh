#!/bin/sh


if [ "$RELAY_ENABLED" = "true" ]; then
    TARGET=http://mock-relay:8560
    SUPPRESS="-S /eth/v1/builder/validators:12:REQUEST"
    LOGARG=""
else
    TARGET=http://execution:8560
    SUPPRESS=""
    LOGARG="-l"
fi

if [ "$MEVBOOST_ENABLED" = "true" ]; then
    TARGET=http://mev-boost:8560
    SUPPRESS="-S /eth/v1/builder/validators:12:REQUEST"
    LOGARG=""
fi

echo "******************** STARTING PROXY ********************"
echo "RELAY_ENABLED[$RELAY_ENABLED] MEVBOOST_ENABLED[$MEVBOOST_ENABLED] TARGET[$TARGET]"

/home/json_rpc_snoop/bin/json_rpc_snoop \
    -p 8560 \
    $LOGARG \
    $SUPPRESS \
    -b 0.0.0.0 \
    $TARGET

