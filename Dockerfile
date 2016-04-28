FROM ubuntu:latest
MAINTAINER Hiroyuki Okada <ok.okada.hiroyuki@gmail.com>
RUN apt-get -qq update
RUN apt-get -y install ruby ruby-dev rubygems-integration git libsqlite3-dev libgmp3-dev
RUN git clone https://github.com/okhiroyuki/docker-sinatra.git /opt/sinatra/
RUN gem install bundler
EXPOSE 9292
RUN cd /opt/sinatra && git pull && bundle install
RUN bundle exec rake db:migrate
CMD ["bundle", "exec", "rackup"]