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

################### DELETE ALL THIS SHIT LATER ###############################
LIBP2PS=(
    # withdrawal-devnet-0-lighthouse-geth-1
    "/ip4/159.89.4.160/tcp/9000/p2p/16Uiu2HAkwqgXRfvvjijtBuR8P9QHmnF7EXDX9rEEXNbmSfabF1zM"
    # withdrawal-devnet-0-lighthouse-nethermind-1
    "/ip4/167.71.56.106/tcp/9000/p2p/16Uiu2HAmQ2J6PuYaCZ9c3g4v46tbcxWtwseHfYrJLYdVEpVf99LE"
    # withdrawal-devnet-0-lighthouse-besu-1
    "/ip4/167.172.180.245/tcp/9000/p2p/16Uiu2HAkznSCVDNEWM5vGQXojMZuPwh43RijepTE8UtPkqqAu7Ea"
    # withdrawal-devnet-0-teku-besu-1
    "/ip4/165.232.72.185/tcp/9000"
    # withdrawal-devnet-0-prysm-geth-1
    "/ip4/138.197.182.199/tcp/9000"
    # withdrawal-devnet-0-prysm-besu-1
    "/ip4/165.232.120.66/tcp/9000"
    # withdrawal-devnet-0-teku-geth-1
    "/ip4/167.71.58.37/tcp/9000"
    # withdrawal-devnet-0-teku-nethermind-1
    "/ip4/165.232.120.62/tcp/9000"
    # withdrawal-devnet-0-lodestar-besu-1
    "/ip4/159.89.27.41/tcp/9000"
    # withdrawal-devnet-0-prysm-nethermind-1
    "/ip4/167.172.168.245/tcp/9000"
)

ENRS=(
    # withdrawal-devnet-0-lighthouse-geth-1
    "enr:-L24QJ2wrQsHawtA7G507tPn1ba1zg4KNaljcn8DbJFhOYIiHsygszAwilfvc4sDO86PfgquLG9vHI_kJiDQLIOKqyKBk4dhdHRuZXRziACipYcGMkIwhGV0aDKQeos5g0AAAED__________4JpZIJ2NIJpcISfWQSgiXNlY3AyNTZrMaECI93uEO3nbyJSyMjbUr-TgWk10EYwLRzO-m_LCmJRKO6Ic3luY25ldHMHg3RjcIIjKIN1ZHCCIyg"
    # withdrawal-devnet-0-lighthouse-nethermind-1
    "enr:-Ly4QKorbfl8uVeFTjCo3SiBJX2qxE7AQE7CvT3PIayatseDZfdTwiv091X2pg6y8I-ReXkdKsEUU7WrgnztcrdxneFvh2F0dG5ldHOIBkAUCAJEgACEZXRoMpB6izmDQAAAQP__________gmlkgnY0gmlwhKdHOGqJc2VjcDI1NmsxoQOo5dDDr3JKP85J1HWSAtisdZGw2pQqOBwcri_A6J-C24hzeW5jbmV0cwCDdGNwgiMog3VkcIIjKA"
    # withdrawal-devnet-0-lighthouse-besu-1
    "enr:-Ly4QAXIG7QaL7ZZj4Y66TsMjXj8s8gtMFyBs1TjBXTJOCHVZMrYdOix7m6JiEGUbyPKX-CuKfAjzxSyiEMoWV93r8sqh2F0dG5ldHOIAGgAAAABBACEZXRoMpB6izmDQAAAQP__________gmlkgnY0gmlwhKestPWJc2VjcDI1NmsxoQJPnAyapySVnLNdk3nGko5nYGm5ANWQj4UsDNGavXXtG4hzeW5jbmV0cwiDdGNwgiMog3VkcIIjKA"
    # withdrawal-devnet-0-teku-besu-1
    "enr:-Ly4QM37vPmjfQTrke9PNaRKb2a7_9NfHJZvJxAiq0iRqNzqQ1fskxo2fSE1TpwCA0FHLdDDBFSG76oqRYsQQ92M_Mowh2F0dG5ldHOIAIEAAAAAQCSEZXRoMpB6izmDQAAAQP__________gmlkgnY0gmlwhKXoSLmJc2VjcDI1NmsxoQLWcI-DU5L6z3bNbp74wID1noLJeUNZYPm2u3WbVbZGf4hzeW5jbmV0cwmDdGNwgiMog3VkcIIjKA"
    # withdrawal-devnet-0-prysm-geth-1
    "enr:-MK4QCJjml00fflU9F8YehhVotBtadbk_pqFCX_i1onP8xpHY5k5QM7z98Fv9XzV2RQieuRYlKGxdb0uZhrR1mWe7NCGAYT3bZvfh2F0dG5ldHOIAAAAAAAAAACEZXRoMpBmw75PQAAAQAEAAAAAAAAAgmlkgnY0gmlwhIrFtseJc2VjcDI1NmsxoQNyH6MvSxiykHyW8MVj4utnRuRfMRRg6QvMJQ8wC9Q3l4hzeW5jbmV0cwCDdGNwgiMog3VkcIIjKA"
    # withdrawal-devnet-0-prysm-besu-1
    "enr:-MK4QCx-nu1GfhEq4xYJCNINcqp7HesyQKgLqNPO5u7EQqfyU9OSBkINNXYA0UNy7UqLbcsMNzOdpfUPMacBMJIZsZmGAYT3bZ0Lh2F0dG5ldHOIAAAAAAAAAACEZXRoMpBmw75PQAAAQAEAAAAAAAAAgmlkgnY0gmlwhKXoeEKJc2VjcDI1NmsxoQKjy6GUOXIO44CqmGQorxlaBNJJ_IXQcW6T7r-e3KvlQIhzeW5jbmV0cwCDdGNwgiMog3VkcIIjKA"
    # withdrawal-devnet-0-teku-geth-1
    "enr:-KG4QD6sQqWFd3daAfuIcnCTuatcA-JEzX7wC825XmoNAfGRRESUr5wzzJanJU_PSBt090MLDZXgbqGmA53VowDcZwxNhGV0aDKQeos5g0AAAED__________4JpZIJ2NIJpcISnRzoliXNlY3AyNTZrMaECZ2RNAtfuvkU5x165d0vB4zamm1MAb2BAL296i_56C9KDdGNwgiMog3VkcIIjKA"
    # withdrawal-devnet-0-teku-nethermind-1
    "enr:-KG4QLNXzm-WUtiQIFzJXyIYKQN63meAGYdopMbu6e0uvd7ZC7meG5eJOE2xRoqmizpPLgfIXpwYXkrQ9Wh325jVFYNOhGV0aDKQeos5g0AAAED__________4JpZIJ2NIJpcISl6Hg-iXNlY3AyNTZrMaEDPevNukiaHmrCJLBMyhrs4U3LH0YNMiPsM8hnj86Qck6DdGNwgiMog3VkcIIjKA"
    # withdrawal-devnet-0-lodestar-besu-1
    "enr:-LK4QITYfD-1ZZ2ES7kVf6fUX6fpZ0H1RXTVV9HoyljK254RXHfhazQTe-VY6CCRdxjKkYnT2PAav3tAmdO-L_Lnx6sGh2F0dG5ldHOIAAAAAAAAAACEZXRoMpBmw75PQAAAQAEAAAAAAAAAgmlkgnY0gmlwhJ9ZGymJc2VjcDI1NmsxoQLrI0USi6cY5GRjIILs40a3DJQTbUfgaEvNgI0dKtp3hIN0Y3CCIyiDdWRwgiMo"
    # withdrawal-devnet-0-prysm-nethermind-1
    "enr:-MK4QF2T8h0gnTKwVyUMdTf7_fhqwBu6YAsVkurxk0max1mweALguF9npLcid4Uzhkf0bCMnv_G0orThGt_xwecUfAqGAYT3bZ0ih2F0dG5ldHOIAAAAAAAAAACEZXRoMpBmw75PQAAAQAEAAAAAAAAAgmlkgnY0gmlwhKesqPWJc2VjcDI1NmsxoQIV1viMhemXb97pRCCLChGH-wvTrtihPa8EQpFfWSYHKohzeW5jbmV0cwCDdGNwgiMog3VkcIIjKA"
)


STATIC_PEERS="--libp2p-addresses=$(bar=$(printf ',%s' ${LIBP2PS[@]}); echo ${bar:1})"
echo "STATIC_PEERS: $STATIC_PEERS"

#BOOTFILE=/shared/${TESTNET_REPO}/${ETH2_TESTNET}/custom_config_data/bootstrap_nodes.txt
#if [ -e $BOOTFILE ]; then
#    BOOT_ARG="--boot-nodes=$(cat $BOOTFILE | tr '\n' ',' | sed 's/,\s*$//')"
#fi

###################### END SHIT TO DELETE ############################

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

if [ -e ./lighthouse.bin ]; then
    LIGHTHOUSE=./lighthouse.bin
else
    LIGHTHOUSE=lighthouse
fi

exec $LIGHTHOUSE \
    --debug-level=debug \
    --datadir ./datadir \
    --testnet-dir=/shared/${TESTNET_REPO}/$ETH2_TESTNET/custom_config_data \
    beacon \
    --disable-enr-auto-update \
    --eth1 \
    $BOOT_ARG \
    $STATIC_PEERS \
    --http \
    --http-address=0.0.0.0 \
    $(printf '%s' "$METRICS_ARG") \
    --http-allow-sync-stalled \
    --eth1-endpoints=http://execution:8545 \
    --disable-packet-filter \
    --jwt-secrets=/shared/jwt.secret \
    --execution-endpoints=$EE_TARGET \
    $RELAY_ARG

