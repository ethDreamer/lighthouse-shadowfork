FROM nethermindeth/nethermind:kiln_shadowfork
#FROM hyperledger/besu:latest

#RUN addgroup -S eth1 -g 1000 && adduser -S eth1 -G eth1 -u 1000
#RUN groupadd -g 1000 eth1 && useradd -r -u 1000 -g eth1 eth1

RUN groupadd -g 1000 eth1 && useradd -r -u 1000 -g eth1 eth1

WORKDIR /home/eth1/run
USER root
RUN chown eth1:eth1 /home/eth1/run
USER eth1

ENTRYPOINT ./execute.sh


