from ruby:2.6

RUN apt update && apt install -y nodejs

RUN gem update --system
RUN gem install bundler

RUN mkdir /app
WORKDIR /app

ADD Gemfile Gemfile.lock /app/

RUN bundle update --bundler
RUN bundle install

ADD . .

RUN mkdir -p tmp/pids

EXPOSE 3000

ENTRYPOINT ["/app/run"]
