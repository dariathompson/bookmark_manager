feature 'delete a bookmark' do
  scenario 'user can delete a bookmark' do
    Bookmark.create(url: 'https://facebook.com', title: 'Facebook')
    visit('/bookmarks')
    expect(page).to have_link('Facebook', href: 'https://facebook.com')

    first('.bookmark').click_button 'Delete'

    expect(current_path).to eq '/bookmarks'
    expect(page).not_to have_link('Facebook', href: 'https://facebook.com')
  end
end