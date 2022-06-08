#!/bin/sh

if [ "$RELAY_ENABLED" = "true" ]; then
    TARGET=http://mock-relay:8560
else
    TARGET=http://execution:8560
fi

echo "******************** STARTING PROXY ********************"
echo "RELAY_ENABLED[$RELAY_ENABLED] TARGET[$TARGET]"

/home/json_rpc_snoop/bin/json_rpc_snoop \
	-p 8560 \
	-l \
	-b 0.0.0.0 \
	 $TARGET

