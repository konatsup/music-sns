require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require './models'

enable :sessions

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

post '/sign_in' do
  user = User.find_by(name: params[:name])
  if user && user.authenticate(params[:password])
    session[:user] = user.id
  end
  redirect '/'
end

post '/sign_up' do
  user = User.find_by(name: params[:name])
  unless user
    @user = User.create(name: params[:name], password: params[:password], password_confirmation: params[:password_confirmation])
    if @user.persisted?
    session[:user] = @user.id
    end
  end
  redirect '/search'
end