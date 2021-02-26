FROM ruby:2.7.2

RUN apt-get update -yqq && apt-get install -yqq --no-install-recommends apt-transport-https

RUN curl -fsSL https://deb.nodesource.com/setup_14.x | bash -

RUN apt-get update -yqq && apt-get install -yqq --no-install-recommends nodejs

RUN npm install -g yarn
RUN gem install bundler -v 2.2.11

COPY Gemfile* /usr/src/app/
WORKDIR /usr/src/app
RUN bundle install

COPY . /usr/src/app/

RUN bin/rails assets:precompile

CMD ["bin/rails", "s", "-b", "0.0.0.0"]
