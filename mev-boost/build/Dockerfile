FROM flashbots/mev-boost

USER root
RUN addgroup -S boost -g 1000 && adduser -S boost -G boost -u 1000

WORKDIR /home/boost/run
RUN chown -R boost:boost /home/boost
USER boost

ENTRYPOINT ./execute.sh

