FROM grafana/grafana

USER root
RUN addgroup -S grafuser -g 1000 && adduser -S grafuser -G grafuser -u 1000
RUN mkdir /tmp/grafold/
RUN mv /etc/grafana/provisioning /tmp/grafold && mv /etc/grafana/grafana.ini /tmp/grafold
RUN cd /etc/grafana && ln -s /home/grafuser/provisioning && ln -s /home/grafuser/grafana.ini

USER grafuser


