# NodeJs + Vue CLI

#### A simple docker configuration to use Node with Vue CLI for development

## Usage

The npm commands you have to use as you need or what you have written in their respective `package.json`.

These examples below is with folders of a local machine called `app` and `api` respectively.

### MAC or Linux
`$ docker container run -d -p 8082:8080 -v $(pwd)/app:/data/app -v /data/app/node_modules -w /data/app -e "CHOKIDAR_USEPOLLING=true" -e "CHOKIDAR_INTERVAL=300" -u node periscuelo/node-vue-cli bash -c "ncu -u && npm install && npm run serve"`

`$ docker container run -d -p 8080:8080 -p 8081:8081 -v $(pwd)/api:/data/api -v /data/api/node_modules -w /data/api -e "CHOKIDAR_USEPOLLING=true" -e "CHOKIDAR_INTERVAL=300" -u node periscuelo/node-vue-cli bash -c "ncu -u && npm install && npm start"`

### Windows PowerShell
`$ docker container run -d -p 8082:8080 -v ${pwd}/app:/data/app -v /data/app/node_modules -w /data/app -e "CHOKIDAR_USEPOLLING=true" -e "CHOKIDAR_INTERVAL=300" -u node periscuelo/node-vue-cli bash -c "ncu -u && npm install && npm run serve"`

`$ docker container run -d -p 8080:8080 -p 8081:8081 -v ${pwd}/api:/data/api -v /data/api/node_modules -w /data/api -e "CHOKIDAR_USEPOLLING=true" -e "CHOKIDAR_INTERVAL=300" -u node periscuelo/node-vue-cli bash -c "ncu -u && npm install && npm start"`

### docker-compose

You can use one container for each application `app` and `api` like below:

```
# docker-compose.yml
version: '3'

services:
  webserver:
    image: periscuelo/node-vue-cli
    working_dir: /data/app/
    command: bash -c "ncu -u &&  npm install && npm run serve"
    environment:
      CHOKIDAR_USEPOLLING: 'true'
      CHOKIDAR_INTERVAL: 300
    ports:
      - 8082:8080
    volumes:
      - ./app:/data/app
      - /data/app/node_modules
    depends_on:
      - api
  api:
    image: periscuelo/node-vue-cli
    working_dir: /data/api/
    command: bash -c "ncu -u && npm install && npm start"
    environment:
      CHOKIDAR_USEPOLLING: 'true'
      CHOKIDAR_INTERVAL: 300
    ports:
      - 8080:8080
      - 8081:8081
    volumes:
      - ./api:/data/api
      - /data/api/node_modules
```
`$ docker-compose up -d`

In this case above, we have in local machine two folders. One for `api` and another to `app`. These folders are sync with the respective containers.

Of course you need to put in `command` the specific commands you need or what you have in their respective `package.json`

### Interactivity with Node
You can use the `terminal` too. For this, use the following command:

`$ docker exec -it ID_OR_NAME_OF_YOUR_CONTAINER /bin/bash`

You have to replace `ID_OR_NAME_OF_YOUR_CONTAINER` for  the respective Container ID or Container NAME.

Ex: If my container id is f3c99c3239ex then, the command must be:

`$ docker exec -it f3c99c3239ex  /bin/bash`

Inside the terminal you can use the `node` as you want.

For example:

`$ npm run lint`

# Enjoy

You can access the server by http://localhost:YOUR_PORT now! Ex: `http://localhost:8080`

Put your JS files in your local `app` OR `api` folder or another folder you have decided.
Access by URL and have fun =)
