FROM ruby:2.5.3-alpine3.8

RUN apk add --update build-base

RUN mkdir /app
WORKDIR /app

ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN BUNDLE_FORCE_RUBY_PLATFORM=1 bundle install --jobs=4

ADD . /app

EXPOSE 8080

CMD ["ruby", "app.rb", "-o", "0.0.0.0", "-p", "8080"]
