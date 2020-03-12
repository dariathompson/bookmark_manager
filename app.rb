# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/flash'
require 'uri'
require './lib/bookmark'
require 'pg'
require './lib/comment'
require './database_connection_setup'
require './lib/tag'
require './lib/bookmark_tag'

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
    flash[:notice] = 'Please submit a valid URL.' unless Bookmark.create(url: params[:url], title: params[:title])
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
    flash[:notice] = 'Please submit a valid URL.' unless Bookmark.update(id: params[:id], url: params[:url], title: params[:title])
    redirect '/bookmarks'
  end

  get '/bookmarks/:id/comments/new' do
    @bookmark_id = params[:id]
    erb :'comments/new'
  end

  post '/bookmarks/:id/comments' do
    Comment.create(text: params[:comment], bookmark_id: params[:id])
    redirect '/bookmarks'
  end

  get '/bookmarks/:id/tags/new' do
    @bookmark_id = params[:id]
    erb :'/tags/new'
  end

  post '/bookmarks/:id/tags' do
    tag = Tag.create(content: params[:tag])
    BookmarkTag.create(bookmark_id: params[:id], tag_id: tag.id)
    redirect '/bookmarks'
  end

  #run! if app_file == $PROGRAM_NAME
  run! if app_file == $0
end
