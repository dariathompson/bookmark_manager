# frozen_string_literal: true

require 'bookmark'
require 'database_helpers'

describe Bookmark do
  let(:comment_class) { double(:comment_class) }

  describe '.create' do
    it 'creates a new bookmark' do
      bookmark = Bookmark.create(url: 'https://facebook.com', title: 'Facebook')
      persisted_data = persisted_data(id: bookmark.id, table: 'bookmarks')

      expect(bookmark).to be_a Bookmark
      expect(bookmark.id).to eq persisted_data.first['id']
      expect(bookmark.title).to eq 'Facebook'
      expect(bookmark.url).to eq 'https://facebook.com'
    end

    it 'does not create a new bookmark if the URL is not valid' do
      Bookmark.create(url: 'not a real bookmark', title: 'not a real bookmark')
      expect(Bookmark.all).to be_empty
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

  describe '.delete' do
    it 'deletes the given bookmark' do
      bookmark = Bookmark.create(url: 'https://makers.tech/', title: 'Makers Academy')

      Bookmark.delete(id: bookmark.id)

      expect(Bookmark.all.length).to eq 0
    end
  end

  describe '.update' do
    it 'deletes the given bookmark' do
      bookmark = Bookmark.create(url: 'https://makers.tech/', title: 'Makers Academy')

      Bookmark.update(id: bookmark.id, url: 'https://google.com/', title: 'Google')

      expect(described_class.all.first.id).to eq bookmark.id
      expect(described_class.all.first.title).to eq 'Google'
      expect(described_class.all.first.url).to eq 'https://google.com/'
    end
  end

  describe '#comments' do
    it 'calls .where on the Comment class' do
      bookmark = Bookmark.create(title: 'Makers Academy', url: 'https://makers.tech/')
      expect(comment_class).to receive(:where).with(bookmark_id: bookmark.id)

      bookmark.comments(comment_class)
    end
  end
end
