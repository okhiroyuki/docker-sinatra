require 'sinatra'
require 'sinatra/activerecord'
require 'json'
require './model.rb'

set :bind, '0.0.0.0'

class Ip < ActiveRecord::Base
end

get '/' do
  @ips = Ip.limit(10).order(:created_at).reverse_order
  erb :index
end

get '/get' do
  content_type :json
  ip = Ip.limit(1).order(:created_at).reverse_order
  data = {address: ip[0].address}
  data.to_json
end

post '/new' , provides: :json do
  params = JSON.parse(request.body.read)
  ip = Ip.new
  ip.address = params["address"]
  ip.save
  redirect '/'
end

delete '/del' do
  ip = Ip.find(params[:id])
  ip.destroy
  redirect '/'
end