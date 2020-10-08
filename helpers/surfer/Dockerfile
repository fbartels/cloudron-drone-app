FROM node:lts-alpine3.11
RUN apk add --no-cache make python
# use --unsafe to not execute post actions as user nobody
RUN npm -g install cloudron-surfer@5.10.4 --unsafe && npm cache clean --force
