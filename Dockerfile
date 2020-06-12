FROM ruby:2.7-buster

RUN curl https://deb.nodesource.com/setup_12.x | bash && \
	curl https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
	echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update && \
	apt-get install -y --no-install-recommends \
	mariadb-client libmariadbd-dev nodejs yarn sudo apt-transport-https ca-certificates tzdata ruby-tzinfo && \
	rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app

# Removed for production use
# RUN gem install rails 
# RUN rails new . --skip-test --webpack --database=mysql

COPY ./project/Gemfile /usr/src/app/

RUN bundle install 

COPY ./project /usr/src/app

EXPOSE 3000


CMD ["rails", "server", "-b", "0.0.0.0"]