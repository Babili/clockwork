FROM ruby:3.2.2-alpine3.17

RUN apk add --update build-base git \
  && rm -rf /var/cache/apk/* \
  && mkdir -p /usr/src/app \
  && addgroup -S babili \
  && adduser -S babili -G babili \
  && mkdir -p /home/babili && chown babili:babili /home/babili \
  && mkdir -p /usr/local/bundler && chown babili:babili -R /usr/local/bundler \
  && chown -R babili:babili /usr/local/bundle

WORKDIR /usr/src/app
USER babili

COPY Gemfile* ./
RUN bundle install

COPY clock.rb ./

ARG APP_ENV=development
ENV RUBY_ENV ${APP_ENV}

CMD ["bundle", "exec", "clockwork", "clock.rb"]
