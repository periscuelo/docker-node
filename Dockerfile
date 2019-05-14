FROM node:lts-slim
LABEL maintainer="Periscuelo"

RUN apt-get -y update \
  && npm i -g @vue/cli \
  && npm i -g npm-check-updates \
  && mkdir -p /data/api/node_modules && chown -R node:node /data/api \
  && mkdir -p /data/app/node_modules && chown -R node:node /data/app
WORKDIR /data/
COPY . .
COPY --chown=node:node . .

USER node

EXPOSE 8000
EXPOSE 8080
EXPOSE 8081
EXPOSE 8082
