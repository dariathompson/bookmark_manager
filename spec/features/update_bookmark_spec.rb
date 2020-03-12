# frozen_string_literal: true

feature 'update a bookmark' do
  scenario 'user can update a bookmark' do
    b = Bookmark.create(url: 'https://facebook.com', title: 'Facebook')
    visit('/bookmarks')
    expect(page).to have_link('Facebook', href: 'https://facebook.com')

    first('.bookmark').click_button 'Update'

    expect(current_path).to eq "/bookmarks/update/#{b.id}"
    fill_in('url', with: 'https://google.com')
    fill_in('title', with: 'Google')
    click_button('Submit')
    expect(page).not_to have_link('Facebook', href: 'https://facebook.com')
    expect(page).to have_link('Google', href: 'https://google.com')
  end
end
