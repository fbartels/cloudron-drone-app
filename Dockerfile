FROM drone/drone:2.5.0 as drone

FROM cloudron/base:3.0.0@sha256:455c70428723e3a823198c57472785437eb6eab082e79b3ff04ea584faf46e92

EXPOSE 8000

# add supervisor configs
RUN sed -e 's,^logfile=.*$,logfile=/run/supervisord.log,' -i /etc/supervisor/supervisord.conf
COPY supervisor-drone-server.conf /etc/supervisor/conf.d/

ENV \
    XDG_CACHE_HOME=/app/data \
    DRONE_SERVER_PROTO=https \
    DRONE_DATABASE_DRIVER=postgres \
    DRONE_RUNNER_OS=linux \
    DRONE_RUNNER_ARCH=amd64 \
    DRONE_SERVER_PORT=:8000 \
    DRONE_DATADOG_ENABLED=false

COPY --from=drone /bin/drone-server /bin

COPY start.sh /app/pkg/

WORKDIR /app/data

CMD [ "/app/pkg/start.sh" ]
