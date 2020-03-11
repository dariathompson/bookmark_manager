require 'sinatra/base'
require 'sinatra/flash'
require 'uri'
require './lib/bookmark'
require './database_connection_setup'

class BookmarkManager < Sinatra::Base
  enable :sessions, :method_override
  register Sinatra::Flash
  get '/' do
    'Hello World'
  end

  get '/bookmarks' do
    @bookmarks = Bookmark.all
    erb :'bookmarks/index'
  end

  get '/bookmarks/new' do
    @bookmarks = Bookmark.all
    erb :'bookmarks/new'
  end

  post '/bookmarks' do
    flash[:notice] = "You must submit a valid URL." unless Bookmark.create(url: params[:url], title: params[:title])
    redirect '/bookmarks'
  end

  delete '/bookmarks/:id' do
    Bookmark.delete(id: params[:id])
    redirect '/bookmarks'
  end

  delete '/bookmarks/:id' do
    Bookmark.delete(id: params[:id])
    redirect '/bookmarks'
  end

  get '/bookmarks/update/:id' do
    @bookmark_id = params[:id]
    erb :'bookmarks/update'
  end

  patch '/bookmarks/:id' do
    flash[:notice] = "You must submit a valid URL." unless Bookmark.update(id: params[:id], url: params[:url], title: params[:title])
    redirect '/bookmarks'
  end

  run! if app_file == $0
end