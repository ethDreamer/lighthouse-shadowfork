#!/bin/bash

rm -f /postgresql/data/.gitignore
sleep 2
/usr/bin/psql -f /tmp/beaconchain-tables.sql -d $POSTGRES_DB -U $POSTGRES_USER
sleep 2

