FROM parithoshj/geth:master

RUN apk add --no-cache ca-certificates tini
VOLUME /home/eth1/run
RUN addgroup -S eth1 -g 1000 && adduser -S eth1 -G eth1 -u 1000

WORKDIR /home/eth1/run
USER eth1

ENTRYPOINT ["/sbin/tini", "-v", "--", "./execute.sh"]
