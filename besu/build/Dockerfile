FROM hyperledger/besu:develop

WORKDIR /home/eth1/run
USER root

RUN apt update && apt install -y tini

RUN chown besu:besu /home/eth1/run
USER besu

ENTRYPOINT ["/usr/bin/tini", "-v", "--", "./execute.sh"]
