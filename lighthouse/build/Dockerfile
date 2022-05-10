FROM sigp/lighthouse:latest-unstable

RUN groupadd -g 1000 beacon && useradd -r -u 1000 -g beacon beacon

WORKDIR /home/beacon/run

USER beacon

ENTRYPOINT ./execute.sh
