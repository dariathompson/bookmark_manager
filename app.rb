require 'sinatra/base'
require './lib/bookmark'
require './database_connection_setup'


class BookmarkManager < Sinatra::Base
  enable :sessions, :method_override
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
    Bookmark.create(url: params[:url], title: params[:title])
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

  put '/bookmarks/update/:id' do
    Bookmark.update(id: params[:id], url: params[:url], title: params[:title])
    erb :'bookmarks/update'
  end

  run! if app_file == $0
end