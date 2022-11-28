FROM drone/drone:2.15.0 as drone

FROM cloudron/base:3.2.0@sha256:ba1d566164a67c266782545ea9809dc611c4152e27686fd14060332dd88263ea

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
