FROM postgres:12.0

RUN mkdir -p /docker-entrypoint-initdb.d
COPY ./tables.sql /tmp/beaconchain-tables.sql
COPY ./postgres/ingest.sh /docker-entrypoint-initdb.d/ingest.sh

RUN groupadd -g 1000 pguser && useradd -r -u 1000 -g pguser pguser

RUN mkdir -p /postgresql/data && chown -R pguser:pguser /postgresql
RUN chmod 0700 /postgresql/data

USER pguser
