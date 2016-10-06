FROM ruby:latest

RUN apt-get update -qq \
			&& apt-get install -y nodejs libpq-dev postgresql-client-9.4 \
			&& rm -rf /var/lib/apt/lists/*

RUN mkdir -p /app
WORKDIR /app
COPY Gemfile /app/
COPY Gemfile.lock /app/

RUN bundle install --jobs 4

ADD . /app

EXPOSE 5000
