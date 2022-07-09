FROM nethermindeth/nethermind:kiln_shadowfork

RUN apt update && apt install -y tini
RUN groupadd -g 1000 eth1 && useradd -r -u 1000 -g eth1 eth1

WORKDIR /home/eth1/run
USER root
RUN chown eth1:eth1 /home/eth1/run
USER eth1

ENTRYPOINT ["/usr/bin/tini", "-v", "--", "./execute.sh"]
