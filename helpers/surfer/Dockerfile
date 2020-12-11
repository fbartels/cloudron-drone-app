FROM node:lts-alpine3.12
RUN apk add --no-cache make python3
# use --unsafe to not execute post actions as user nobody
RUN npm -g install cloudron-surfer@5.12.2 --unsafe && npm cache clean --force && surfer -h
