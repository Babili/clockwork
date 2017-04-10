FROM ruby:2.3-onbuild

ARG APP_ENV=development
ENV RUBY_ENV ${APP_ENV}

CMD ["clockwork", "/usr/src/app/clock.rb"]
