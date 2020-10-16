FROM plugins/docker:latest
RUN apk add --no-cache jq make npm perl python
ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz && \
    tar -C /usr/local/bin -xzvf dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz && \
    rm dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz

# use --unsafe to not execute post actions as user nobody
RUN npm -g install cloudron@4.5.3 --unsafe && npm cache clean --force && \
    cloudron --version
