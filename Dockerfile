FROM ruby:2.7.5

RUN apt-get update -qq \
&& apt-get install -y nodejs postgresql-client

#Install Cron
RUN apt-get -y install cron

ADD . /Rails-Docker
WORKDIR /Rails-Docker
RUN bundle install

RUN bundle exec whenever --update-crontab --set environment=development

EXPOSE 3000

CMD ["bash"]
