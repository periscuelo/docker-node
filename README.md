# NodeJs + Vue CLI

#### A simple docker configuration to use Node with Vue CLI for development

## Notes

If you are using Docker Toolbox in Windows Home (because Windows Pro have a Docker Installation) you have
to open one prompt like administrator and use the commands below:

```
$ netsh interface portproxy add v4tov4 listenport=8000 listenaddress=localhost connectport=8000 connectaddress=192.168.99.100

$ netsh interface portproxy add v4tov4 listenport=8081 listenaddress=localhost connectport=8081 connectaddress=192.168.99.100

$ netsh interface portproxy add v4tov4 listenport=8082 listenaddress=localhost connectport=8082 connectaddress=192.168.99.100
```

Probablely your IP in docker is `192.168.99.100` but if don't, change for the respective IP.

After, you need open a notepad like administrator, and access folder `C:\Windows\System32\drivers\etc`, change type of files to `All Files` and select hosts.

Inside of hosts, added the line below:

`192.168.99.100 localhost`

Save the File. Now you be able to access localhost:8080 for example, using Docker Toolbox on Windows Home =)

## Usage

The npm commands you have to use as you need or what you have written in their respective `package.json`.

These examples below is with folders of a local machine called `app` and `api` respectively.

### MAC or Linux
`$ docker container run -d -p 8000:8000 -p 8080:8080 -v $(pwd)/app:/data/app -v /data/app/node_modules -w /data/app -e "CHOKIDAR_USEPOLLING=true" -e "CHOKIDAR_INTERVAL=300" -u node periscuelo/node-vue-cli bash -c "ncu -u && npm i && vue ui"`

`$ docker container run -d -p 8082:8080 -p 8081:8081 -v $(pwd)/api:/data/api -v /data/api/node_modules -w /data/api -e "CHOKIDAR_USEPOLLING=true" -e "CHOKIDAR_INTERVAL=300" -u node periscuelo/node-vue-cli bash -c "ncu -u && npm i && npm start"`

### Windows PowerShell
`$ docker container run -d -p 8000:8000 -p 8080:8080 -v ${pwd}/app:/data/app -v /data/app/node_modules -w /data/app -e "CHOKIDAR_USEPOLLING=true" -e "CHOKIDAR_INTERVAL=300" -u node periscuelo/node-vue-cli bash -c "ncu -u && npm i && vue ui"`

`$ docker container run -d -p 8082:8080 -p 8081:8081 -v ${pwd}/api:/data/api -v /data/api/node_modules -w /data/api -e "CHOKIDAR_USEPOLLING=true" -e "CHOKIDAR_INTERVAL=300" -u node periscuelo/node-vue-cli bash -c "ncu -u && npm i && npm start"`

### docker-compose

You can use one container for each application `app` and `api` like below:

```
# docker-compose.yml
version: '3'

services:
  webserver:
    image: periscuelo/node-vue-cli
    working_dir: /data/app/
    command: bash -c "ncu -u && npm i && vue ui"
    stdin_open: true
    tty: true
    environment:
      CHOKIDAR_USEPOLLING: 'true'
      CHOKIDAR_INTERVAL: 300
    ports:
      - 8000:8000
      - 8080:8080
    volumes:
      - ./app:/data/app
      - /data/app/node_modules
    depends_on:
      - api
  api:
    image: periscuelo/node-vue-cli
    working_dir: /data/api/
    command: bash -c "ncu -u && npm i && npm start"
    stdin_open: true
    tty: true
    environment:
      CHOKIDAR_USEPOLLING: 'true'
      CHOKIDAR_INTERVAL: 300
    ports:
      - 8082:8080
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

`$ docker exec -it ID_OR_NAME_OF_YOUR_CONTAINER bash`

You have to replace `ID_OR_NAME_OF_YOUR_CONTAINER` for  the respective Container ID or Container NAME.

Ex: If my container id is f3c99c3239ex then, the command must be:

`$ docker exec -it f3c99c3239ex bash`

Inside the terminal you can use the `node` as you want.

For example:

`$ npm run lint`

# Enjoy

You can access the server by http://localhost:YOUR_PORT now! Ex: `http://localhost:8000`

Put your JS files in your local `app` OR `api` folder or another folder you have decided.
Access by URL and have fun =)
