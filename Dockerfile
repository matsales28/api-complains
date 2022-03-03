FROM ruby:2.6.9

WORKDIR /api-complains

COPY Gemfile Gemfile.lock ./
RUN mkdir -p log && touch log/development.log

RUN gem install bundler

RUN bundle install

RUN gem install foreman

# Start the main process.
CMD ["foreman", "start", "-f", "Procfile"]