FROM ruby:2.6.5

RUN apt-get update -y && apt-get install -y build-essential libjemalloc-dev && \
  mkdir -p /usr/src/app && \
  groupadd -r babili && useradd -r -g babili babili && \
  mkdir -p /home/babili && chown babili:babili /home/babili

WORKDIR /usr/src/app
USER babili

COPY Gemfile* ./
RUN bundle install

COPY . .

ARG APP_ENV=development
ENV RUBY_ENV ${APP_ENV}

CMD ["clockwork", "/usr/src/app/clock.rb"]
