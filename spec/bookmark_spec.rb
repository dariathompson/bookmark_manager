require 'bookmark'
require 'database_helpers'

describe Bookmark do
  describe '.create' do
    it 'creates a new bookmark' do
      bookmark = Bookmark.create(url: 'https://facebook.com', title: 'Facebook')
      persisted_data = persisted_data(id: bookmark.id)

      expect(bookmark).to be_a Bookmark
      expect(bookmark.id).to eq persisted_data.first['id']
      expect(bookmark.title).to eq 'Facebook'
      expect(bookmark.url).to eq 'https://facebook.com'
    end
  end

  describe '.all' do
    it 'returns all bookmarks' do
      connection = PG.connect(dbname: 'bookmark_manager_test')

      bookmark = Bookmark.create(url: 'https://makers.tech/', title: 'Makers Academy')
      Bookmark.create(url: 'https://www.google.com/', title: 'Google')
      Bookmark.create(url: 'https://www.netflix.com/browse', title: 'Netflix')

      bookmarks = Bookmark.all

      expect(bookmarks.length).to eq 3
      expect(bookmarks.first).to be_a Bookmark
      expect(bookmarks.first.id).to eq bookmark.id
      expect(bookmarks.first.title).to eq 'Makers Academy'
      expect(bookmarks.first.url).to eq 'https://makers.tech/'
    end
  end
end