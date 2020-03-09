feature 'viewing a list of bookmarks' do
  scenario 'returns a list of bookmarks' do
    visit ('/bookmarks')
    expect(page).to have_content 'https://makers.tech/'
    expect(page).to have_content 'https://www.google.com/'
    expect(page).to have_content 'https://www.netflix.com/browse'
  end
end