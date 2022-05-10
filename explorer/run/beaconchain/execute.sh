#!/bin/sh

#while [ 1 ]; do
#   sleep 10
#done

./mkconfig.py /shared/merge-testnets/${ETH2_TESTNET}/config.yaml /app/config.yml > ./config-${ETH2_TESTNET}.yml

sleep 5

cd /app
exec ./explorer --config /home/beacon/run/config-${ETH2_TESTNET}.yml
