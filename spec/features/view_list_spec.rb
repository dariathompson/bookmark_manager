feature 'viewing a list of bookmarks' do
  scenario 'returns a list of bookmarks' do
    connection = PG.connect(dbname: 'bookmark_manager_test')

    Bookmark.create(url: 'https://makers.tech/')
    Bookmark.create(url: 'https://www.google.com/')
    Bookmark.create(url: 'https://www.netflix.com/browse/')

    visit ('/bookmarks')

    expect(page).to have_content 'https://makers.tech/'
    expect(page).to have_content 'https://www.google.com/'
    expect(page).to have_content 'https://www.netflix.com/browse'
  end
end