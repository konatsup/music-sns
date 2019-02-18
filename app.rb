require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?

get '/' do
  erb :index
end

get '/sign_up' do
  erb :signup
end

get '/search' do
  erb :search
end

get '/home' do
  erb :home
end

get '/edit/:id' do
  erb :edit
end