# Ruby on rails boilerplate inside Docker container
This repository contains a ruby on rails boilerplate
to develop projects inside Docker containers on 
any OS. Is  

## Setup a new rails project
This part describe how to setup a rails project 
manually or using a script.

Setup manually:
```
docker-compose run rails bash -c "rails new -f --database=mysql /usr/src/project"
```

Setup using included script:
```
docker run --rm --name ruby_install -v ${PWD}/data/project:/usr/src/project -w /usr/src/project ruby:2.7-buster bash /usr/src/app/setup.sh
```

## Define environment variables
Define variables in the ``.env`` file to pass data to the application.

## Development
This part describe how to use rails tools from cli with docker-compose.

### Execute a bash inside the rails container
To run this command this suppose your app is named ``rails`` (check docker-compose.yml)
in ``docker-compose.yml`` and volumes are mounted to host to be persistent. Start containers and project with ``docker-compose up``. 

```
docker-compose exec rails bash 
```

### Execute a command inside the rails container

```
docker-compose exec rails bash -c "insert command here"
```

Example:
```
docker-compose exec rails bash -c "rails g controller MyController"
```

