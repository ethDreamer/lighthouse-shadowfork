FROM sigp/lighthouse:latest-unstable

RUN apt update && apt install -y tini
RUN groupadd -g 1000 beacon && useradd -r -u 1000 -g beacon beacon

WORKDIR /home/beacon/run

USER beacon

ENTRYPOINT ["/usr/bin/tini", "-v", "--", "./execute.sh"]
