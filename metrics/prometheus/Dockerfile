FROM prom/prometheus

USER root
RUN addgroup -S promuser -g 1000 && adduser -S promuser -G promuser -u 1000
USER promuser

ENTRYPOINT [ "/home/promuser/execute.sh" ]

