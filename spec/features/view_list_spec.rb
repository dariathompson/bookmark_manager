feature 'viewing a list of bookmarks' do
  scenario 'returns a list of bookmarks' do
    connection = PG.connect(dbname: 'bookmark_manager_test')

    connection.exec("INSERT INTO bookmarks (url) VALUES('https://makers.tech/');")
    connection.exec("INSERT INTO bookmarks (url) VALUES('https://www.google.com/');")
    connection.exec("INSERT INTO bookmarks (url) VALUES('https://www.netflix.com/browse');")

    visit ('/bookmarks')

    expect(page).to have_content 'https://makers.tech/'
    expect(page).to have_content 'https://www.google.com/'
    expect(page).to have_content 'https://www.netflix.com/browse'
  end
end