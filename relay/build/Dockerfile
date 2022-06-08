FROM ethdreamer/mock-relay:latest

USER root
RUN groupadd -g 1000 relay && useradd -r -u 1000 -g relay relay

WORKDIR /home/relay/run
RUN chown -R relay:relay /home/relay
USER relay

ENTRYPOINT ./execute.sh

