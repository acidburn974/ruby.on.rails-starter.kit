# Ruby on rails boilerplate inside Docker container
This repository contains a ruby on rails boilerplate
to develop projects inside Docker containers on 
any OS. Is  

## Setup a new rails project
This part describe how to setup a rails project manually or 
using a script.

### Setup using an existing Gemfile
The first way is to create a Gemfile and the Dockerfile will 
copy it at build.

Create a ``Gemfile`` in ``./project`` then execute ```docker-compose build```

### Setup using rails cli
The second way is to generate with Gemfile with rails from an 
interactive cli. 

You can do it manually : run bash inside a ruby container and 
share the ``./project`` folder. Then generate a new project using rails (``gem install rails && rails new /usr/src/app -f --skip-test --webpack --database=mysql``). This command will fail without all required dependencies installed.

Or you can use the ``./project/setup.sh`` script using a single command. This script download NodeJS, Yarn and RoR then will generate a new rails application in /usr/src/app which is mounted in ``./project`` on host.

```
docker run --rm --name ruby -v ${PWD}/project:/usr/src/app -w /usr/src/app jruby:9.2 \
bash /usr/src/app/setup.sh
```

## Use tools to develop
This part describe how to use rails tools from cli with docker-compose.

### Execute a bash inside the rails container
To run this command this suppose your app is named ``rails``
in ``docker-compose.yml`` and volumes are mounted to host to be persistent. Start containers and project with ``docker-compose up``. 
You can add ``-d`` to get ip up as a daemon. 

```
docker-compose exec rails bash 
```

### Execute a command inside the rails container
Example:

```
docker-compose exec rails bash -c "rails g controller MyController"
```

