FROM node:lts-slim
LABEL maintainer="Periscuelo"

RUN apt-get -y update \
  && npm i -g @vue/cli \
  && sed -i 's/subscriptionsPath/host: "0.0.0.0", subscriptionsPath/' /usr/local/lib/node_modules/@vue/cli/lib/ui.js \
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
