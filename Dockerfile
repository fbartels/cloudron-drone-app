FROM drone/drone:1.9.1 as drone

FROM cloudron/base:2.0.0@sha256:f9fea80513aa7c92fe2e7bf3978b54c8ac5222f47a9a32a7f8833edf0eb5a4f4

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
