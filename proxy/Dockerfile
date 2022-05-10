FROM parithoshj/json_rpc_snoop:v1.0.0-x86

USER root
RUN chown -R json_rpc_snoop:json_rpc_snoop /home/json_rpc_snoop
USER json_rpc_snoop
RUN mkdir /home/json_rpc_snoop/run

ENTRYPOINT /home/json_rpc_snoop/run/execute.sh
