#!/bin/sh

/bin/prometheus \
    --web.listen-address=0.0.0.0:9090 \
    --config.file=/home/promuser/prometheus.yml \
    --storage.tsdb.path=/home/promuser/data \
    --web.console.libraries=/usr/share/prometheus/console_libraries \
    --web.console.templates=/usr/share/prometheus/consoles


