FROM ruby:2.3

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

RUN gem install bundler

RUN mkdir /mazurik_blog
WORKDIR /mazurik_blog

ADD Gemfile /mazurik_blog/Gemfile
ADD Gemfile.lock /mazurik_blog/Gemfile.lock

RUN bundle install

RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ jessie-pgdg main" >> /etc/apt/sources.list.d/postgresql.list
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN apt update
RUN apt install -y postgresql-client-9.6
RUN rm -f /mazurik_blog/tmp/pids/server.pid

# Default command
CMD ["bundle exec rails server"]
