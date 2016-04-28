FROM ubuntu:latest

RUN apt-get -q update
RUN apt-get -y install ruby ruby-dev rubygems git
RUN git clone https://github.com/okhiroyuki/docker-sinatra.git /opt/sinatra/
RUN gem install bundler
EXPOSE 9292
RUN cd /opt/sinatra && git pull && bundle install
RUN bundle exec rake db:migrate
CMD ["bundle", "exec", "rackup"]