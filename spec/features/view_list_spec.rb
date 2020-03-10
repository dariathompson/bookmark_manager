feature 'viewing a list of bookmarks' do
  scenario 'returns a list of bookmarks' do
    connection = PG.connect(dbname: 'bookmark_manager_test')

    Bookmark.create(url: 'https://makers.tech/', title: 'Makers Academy')
    Bookmark.create(url: 'https://www.google.com/', title: 'Google')
    Bookmark.create(url: 'https://www.netflix.com/browse/', title: 'Netflix')

    visit ('/bookmarks')

    expect(page).to have_link('Makers Academy', href: 'https://makers.tech/')
    expect(page).to have_link('Google', href: 'https://www.google.com/')
    expect(page).to have_link('Netflix', href: 'https://www.netflix.com/browse/')
  end
end