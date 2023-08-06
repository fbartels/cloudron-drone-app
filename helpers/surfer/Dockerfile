FROM node:lts-alpine
RUN apk add --no-cache make python3 zip
# use --unsafe to not execute post actions as user nobody
RUN npm -g install cloudron-surfer@6.0.0 --unsafe && npm cache clean --force && surfer --version
