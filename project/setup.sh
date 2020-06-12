#!/bin/bash
# This script seutp a new rails application in /usr/src/app directory
# Use this script only to setup your dev environment
# https://github.com/jruby/jruby/wiki/GettingStarted

curl https://deb.nodesource.com/setup_12.x | bash && \
	curl https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
	echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list


apt-get update && \
	apt-get install -y --no-install-recommends \
	mariadb-client libmariadbd-dev nodejs yarn sudo apt-transport-https ca-certificates tzdata ruby-tzinfo \
    build-essential dh-autoreconf && \
	rm -rf /var/lib/apt/lists/*

#gem install rails

jruby -S gem list --local
jruby -S gem install rails activerecord-jdbcmysql-adapter bindex

jruby -S rails new /usr/src/app -f --skip-test --webpack --database=mysql