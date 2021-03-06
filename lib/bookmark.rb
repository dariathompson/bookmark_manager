# frozen_string_literal: true

require_relative 'database_connection'
require 'uri'
require_relative './comment'
require_relative './tag'
class Bookmark
  attr_reader :id, :title, :url
  def initialize(id:, title:, url:)
    @id = id
    @title = title
    @url = url
  end

  def self.create(url:, title:)
    return false unless is_url?(url)

    result = DatabaseConnection.query("INSERT INTO bookmarks (url, title) VALUES('#{url}', '#{title}') RETURNING id, title, url")
    Bookmark.new(id: result[0]['id'], title: result[0]['title'], url: result[0]['url'])
  end

  def self.all
    bookmarks = DatabaseConnection.query('SELECT * FROM bookmarks')
    bookmarks.map do |bookmark|
      Bookmark.new(id: bookmark['id'], title: bookmark['title'], url: bookmark['url'])
    end
  end

  def self.delete(id:)
    DatabaseConnection.query("DELETE FROM bookmark_tags WHERE bookmark_id = #{id}; DELETE FROM comments WHERE bookmark_id = #{id}; DELETE FROM bookmarks WHERE id = #{id}")
  end

  def self.update(id:, title:, url:)
    return false unless is_url?(url)

    DatabaseConnection.query("UPDATE bookmarks SET title = '#{title}', url = '#{url}' WHERE id = #{id}")
  end

  def self.where(tag_id:)
    result = DatabaseConnection.query("SELECT bookmarks.id, title, url FROM bookmark_tags INNER JOIN bookmarks ON bookmarks.id = bookmark_tags.bookmark_id WHERE bookmark_tags.tag_id = '#{tag_id}';")
    result.map do |bookmark|
      Bookmark.new(id: bookmark['id'], title: bookmark['title'], url: bookmark['url'])
    end
  end

  def comments(comment_class = Comment)
    comment_class.where(bookmark_id: id)
  end

  def tags(tag_class = Tag)
    tag_class.where(bookmark_id: id)
  end

  private

  def self.is_url?(url)
    url =~ URI::DEFAULT_PARSER.regexp[:ABS_URI]
  end
end
