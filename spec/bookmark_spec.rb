require 'bookmark'

describe Bookmark do
  describe '.all' do
    it 'returns all bookmarks' do
      connection = PG.connect(dbname: 'bookmark_manager_test')

      connection.exec("INSERT INTO bookmarks (url) VALUES ('https://makers.tech/');")
      connection.exec("INSERT INTO bookmarks (url) VALUES('https://www.google.com/');")
      connection.exec("INSERT INTO bookmarks (url) VALUES('https://www.netflix.com/browse');")

      bookmarks = Bookmark.all

      expect(bookmarks).to include("https://makers.tech/")
      expect(bookmarks).to include("https://www.google.com/")
      expect(bookmarks).to include("https://www.netflix.com/browse")
    end
  end
end