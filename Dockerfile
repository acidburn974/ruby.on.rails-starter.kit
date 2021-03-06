FROM ruby:2.7-buster

# install compilation tools
RUN apt-get update -qq && apt-get install -y build-essential apt-transport-https ca-certificates curl lsb-release tzdata ruby-tzinfo

# for mariadb
RUN apt-get install -y libmariadbd-dev mariadb-client

# for nokogiri
RUN apt-get install -y libxml2-dev libxslt1-dev

# for capybara-webkit
RUN apt-get install -y libqtwebkit4 libqt4-dev xvfb

# for a latest JS runtime
RUN curl -sL https://deb.nodesource.com/setup_lts.x | bash

# install nodejs
RUN apt-get install -y nodejs

# install yarn globally from nodejs
RUN npm install -g yarn && yarn -v

# create the directory
RUN mkdir /usr/src/project

# set it as working directory
WORKDIR /usr/src/project

# copy Gemfile
COPY ./data/project/Gemfile /usr/src/project/Gemfile

# copy Gemfile.lock
COPY ./data/project/Gemfile.lock /usr/src/project/Gemfile.lock

# install rails and dependencies
RUN gem install rails 

# install gems
RUN bundle install

# copy entrypoint script to container
COPY entrypoint.sh /usr/bin/entrypoint.sh

# chmod it to be executable
RUN chmod +x /usr/bin/entrypoint.sh

# run the script on container start
ENTRYPOINT ["entrypoint.sh"]

# expose the default rails port
EXPOSE 3000

# start rails service
CMD ["rails", "server", "-b", "0.0.0.0"]