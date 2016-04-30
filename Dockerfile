FROM ubuntu:latest
MAINTAINER Hiroyuki Okada <ok.okada.hiroyuki@gmail.com>
RUN apt-get -qq update
RUN apt-get -qqy install ruby ruby-dev rubygems-integration git libsqlite3-dev libgmp3-dev build-essential
RUN git clone https://github.com/okhiroyuki/docker-sinatra.git /opt/sinatra/
RUN gem install bundler 
RUN gem install json -v '1.8.3'
EXPOSE 1881
WORKDIR /opt/sinatra
RUN git pull && bundle install
RUN bundle exec rake db:create
RUN bundle exec rake db:migrate
CMD ["bundle", "exec", "rackup","config.ru","--port","1881","-o","0.0.0.0"]