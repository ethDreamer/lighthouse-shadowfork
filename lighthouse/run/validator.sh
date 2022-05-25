#!/bin/bash

MNEMONIC_TMP=/tmp/mnemonic.tmp
PASSWORD_TMP=/tmp/wallet.pass
WALLET_DIR=./datadir/wallets
SECRET_DIR=./datadir/secrets
PRIVKY_DIR=./datadir/validators
WALLET_NAME=default

cleanup() {
    if [ -f $MNEMONIC_TMP ]; then
        shred $MNEMONIC_TMP && rm $MNEMONIC_TMP
    fi
    if [ -f $PASSWORD_TMP ]; then
        shred $PASSWORD_TMP && rm $PASSWORD_TMP
    fi
}

generate_wallet() {
    lighthouse \
        --datadir ./datadir \
        --testnet-dir=/shared/merge-testnets/$ETH2_TESTNET \
        account_manager \
        wallet \
        recover \
        --mnemonic-path $MNEMONIC_TMP \
        --password-file $PASSWORD_TMP \
        --name $WALLET_NAME 
}

generate_validators() {
    lighthouse \
        --datadir ./datadir \
        --testnet-dir=/shared/merge-testnets/$ETH2_TESTNET \
        account_manager \
        validator \
        create \
        --wallet-name $WALLET_NAME \
        --count $VALIDATOR_COUNT \
        --wallet-password $PASSWORD_TMP
}

if [ -z "$VALIDATOR_MNEMONIC" ] || [ "$VALIDATOR_COUNT" -eq "0" ]; then
    exit 0
fi

if [[ $(find $SECRET_DIR -maxdepth 1 -type f 2>/dev/null | wc -l) -eq 0 ]]; then
    if [[ $(find $WALLET_DIR -maxdepth 1 -type d 2>/dev/null | wc -l) -eq 0 ]]; then
        echo "Generating wallet from mnemonic.."
        # need to generate wallet
        echo $VALIDATOR_MNEMONIC > $MNEMONIC_TMP && \
        generate_wallet || {
            echo "Error: Wallet Generation Failed"
            rm -rf $WALLET_DIR
            cleanup
            exit 1
        }
    fi

    echo "Generating validators from wallet.."
    generate_validators || {
        echo "Error: Validator Generation Failed"
        rm -rf $SECRET_DIR $PRIVKEY_DIR
        cleanup
        exit 1
    }
    cleanup
fi

#while [ 1 ]; do
#    sleep 10;
#done

if [ ! -z ${VALIDATOR_GRAFFITI+x} ]; then
    GRAFFITI_ARG="\-\-graffiti=\"$VALIDATOR_GRAFFITI\""
#    printf '<%s> ' $GRAFFITI_ARG ; echo
fi
if [ ! -z ${FEE_RECIPIENT+x} ]; then
    FEE_ARG="--suggested-fee-recipient=$FEE_RECIPIENT"
fi

echo "******************* STARTING LIGHTHOUSE VALIDATOR NODE *******************"

exec lighthouse \
    --debug-level=info \
    --datadir ./datadir \
    --testnet-dir=/shared/merge-testnets/$ETH2_TESTNET \
    validator_client \
    --http \
    --http-port 5062 \
    --http-address=0.0.0.0 \
    --unencrypted-http-transport \
    --http-allow-origin \* \
    --metrics \
    --metrics-address=0.0.0.0 \
    --metrics-allow-origin \* \
    --init-slashing-protection \
    --beacon-nodes http://consensus-bn:5052 \
    --graffiti="$VALIDATOR_GRAFFITI" \
    $FEE_ARG
