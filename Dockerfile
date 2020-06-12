FROM jruby:9.2

RUN curl https://deb.nodesource.com/setup_12.x | bash && \
    curl https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    mariadb-client libmariadbd-dev nodejs yarn sudo apt-transport-https ca-certificates tzdata ruby-tzinfo \
    build-essential dh-autoreconf && \
    rm -rf /var/lib/apt/lists/*


# WORKDIR /usr/src/app
# Removed for production use
# RUN gem install rails 
# RUN rails new . --skip-test --webpack --database=mysql

COPY ./project/Gemfile /usr/src/app/

WORKDIR /usr/src/app

RUN jruby -S gem install rails activerecord-jdbcmysql-adapter bindex
RUN jruby -S bundle install 

COPY ./project /usr/src/app

WORKDIR /usr/src/app

EXPOSE 8000
# https://github.com/jruby/jruby/wiki/GettingStarted
CMD ["jruby", "-S", "rails", "server", "-b", "0.0.0.0", "-p", "8000"]