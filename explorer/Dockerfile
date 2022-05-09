FROM parithoshj/beacon-explorer:print-chain-id

RUN apk --no-cache add bash python3 py3-ruamel

RUN addgroup -S beacon -g 1000 && adduser -S beacon -G beacon -u 1000
WORKDIR /home/beacon/run
RUN chown beacon:beacon /home/beacon/run

USER beacon

ENTRYPOINT ./execute.sh
