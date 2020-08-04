#!/bin/bash
# This script setup a new rails application in /usr/src/app directory of the container
# Do not use this script in production

# update and install compilation tools
apt-get update -qq && apt-get install -y build-essential apt-transport-https ca-certificates curl lsb-release tzdata ruby-tzinfo

# for mariadb
apt-get install -y libmariadbd-dev mariadb-client
w
# for nokogiri
apt-get install -y libxml2-dev libxslt1-dev

# for capybara-webkit
apt-get install -y libqtwebkit4 libqt4-dev xvfb

# for a latest JS runtime
curl -sL https://deb.nodesource.com/setup_lts.x | bash

# install nodejs
apt-get update && apt-get install -y nodejs

# install yarn globally from nodejs
npm install -g yarn && yarn -v 

# install ruby gem for rails installation
jruby -S gem install rails activerecord-jdbcmysql-adapter bindex

# generate a new rails project
jruby -S rails new /usr/src/app -f --webpack --database=mysql