# NAME: rubychina/bundler-api
FROM homeland/base:0.2.3

ADD . /var/www/bundler-api
WORKDIR /var/www/bundler-api

RUN bundle install --deployment

EXPOSE 5000
ENTRYPOINT ["/var/www/bundler-api/script/web"]
