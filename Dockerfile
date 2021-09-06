from ruby:2.6.6

RUN apt update && apt install -y nodejs

RUN gem update --system
RUN gem install bundler

RUN mkdir /app
WORKDIR /app

EXPOSE 3000

ENTRYPOINT ["/app/bin/docker-run"]

ENV RAILS_SERVE_STATIC_FILES 1
ENV RAILS_LOG_TO_STDOUT 1

ADD Gemfile Gemfile.lock /app/

RUN bundle update --bundler
RUN bundle install

ADD . .

RUN bundle exec rake assets:precompile

RUN mkdir -p tmp/pids
