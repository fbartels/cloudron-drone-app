FROM node:lts-alpine3.12
RUN apk add --no-cache make python3 zip
# use --unsafe to not execute post actions as user nobody
RUN npm -g install cloudron-surfer@5.16.6 --unsafe && npm cache clean --force && surfer --version
