require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require './models'

require 'open-uri'
require 'net/http'
require 'json'

enable :sessions

helpers do
  def current_user
    User.find_by(id: session[:user])
  end

  def authorize
    if current_user.nil?
      redirect '/'
    end
  end

end

before '/search' do
  authorize
end

before '/home' do
  authorize
end

before '/edit/*' do
  authorize
end

get '/' do
  @posts = Post.all
  erb :index
end

get '/sign_up' do
  erb :signup
end

get '/search' do
  if @musics.nil?
    @musics = []
  end
  erb :search
end

get '/home' do
  @posts = Post.all
  erb :home
end

get '/edit/:id' do
  @post = Post.find_by(id: params[:id])
  erb :edit
end

get '/sign_out' do
  session[:user] = nil
  redirect '/'
end

get '/posts/:id/delete' do
  post = Post.find(params[:id])
  post.destroy
  redirect '/home'
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

post '/search' do
  keyword = params[:keyword]
  uri = URI("https://itunes.apple.com/search")
  uri.query = URI.encode_www_form({
    term: keyword,
    country: "US",
    media: "music",
    limit: 10
  })
  res = Net::HTTP.get_response(uri)
  returned_json = JSON.parse(res.body)
  @musics = returned_json["results"]

  erb :search
end

post '/posts/new' do
  comment = params[:comment]
  if !comment.blank?
    current_user.posts.create(
      comment: CGI.escapeHTML(params[:comment]),
      artist: params[:artist],
      album: params[:album],
      track: params[:track],
      image_url: params[:image_url],
      music_url: params[:music_url])
    redirect '/home'
  else
    redirect '/search'
  end
end

post '/posts/:id/update' do
  post = Post.find(params[:id])
  comment = params[:comment]
  if !comment.blank?
    post.comment = CGI.escapeHTML(comment)
    post.save
    redirect '/home'
  else
    redirect '/edit/#{post.id}'
  end
end