FROM ruby:2.6
MAINTAINER Ruslan Gafurov <shkrt.contact@gmail.com>

WORKDIR /app

RUN gem install bundler
COPY ./Gemfile /app/Gemfile
COPY ./Gemfile.lock /app/Gemfile.lock
RUN bundle install
COPY . /app/

ENTRYPOINT ["entrypoint.sh"]
