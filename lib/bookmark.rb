require 'database_connection'
class Bookmark
  attr_reader :id, :title, :url
  def initialize(id:, title:, url:)
    @id = id
    @title = title
    @url = url
  end

  def self.create(url:, title:)
    #return false unless is_url?(url)
    result = DatabaseConnection.query("INSERT INTO bookmarks (url, title) VALUES('#{url}', '#{title}') RETURNING id, title, url;")
    Bookmark.new(id: result[0]['id'], title: result[0]['title'], url: result[0]['url'])
  end

  def self.all
    result = DatabaseConnection.query('SELECT * FROM bookmarks;')
    result.map do |bookmark| 
      Bookmark.new(id: bookmark['id'], title: bookmark['title'], url: bookmark['url'])
    end
  end

  def self.delete(id:)
    DatabaseConnection.query("DELETE FROM bookmarks WHERE id = #{id}")
  end

  def self.update(id:, title:, url:)
    DatabaseConnection.query("UPDATE bookmarks SET title = '#{title}', url = '#{url}' WHERE id = #{id} RETURNING id, url, title;")
  end
end