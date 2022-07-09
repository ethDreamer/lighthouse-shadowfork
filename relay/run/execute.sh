#!/bin/sh

/usr/local/bin/mock-relay \
    --address 0.0.0.0 \
    --beacon-node http://consensus-bn:5052 \
    --execution-endpoint http://execution:8560 \
    --port 8560 \
    --jwt-secret /shared/jwt.secret

