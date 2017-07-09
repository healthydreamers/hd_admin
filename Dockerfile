FROM ruby:2.4.1-alpine
MAINTAINER Ismail Mechbal <ismail@werunik.com>

ENV BUILD_PACKAGES bash curl-dev build-base postgresql-dev nodejs git

# Update and install all of the required packages.
# At the end, remove the apk cache
RUN apk update && \
    apk upgrade && \
    apk add $BUILD_PACKAGES && \
    rm -rf /var/cache/apk/*

ENV APP_HOME /webapps/admin
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/
RUN echo 'gem: --no-rdoc --no-ri' >> /.gemrc
RUN bundle install
#RUN bundle install --deployment
#RUN bundle install --path vendor/cache

COPY . $APP_HOME/

ENTRYPOINT ["bundle", "exec"]