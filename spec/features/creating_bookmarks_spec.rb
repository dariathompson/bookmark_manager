# frozen_string_literal: true

feature 'adding a new bookmark' do
  scenario 'user can add a new bookmark' do
    visit('/bookmarks/new')
    fill_in('url', with: 'https://facebook.com')
    fill_in('title', with: 'Facebook')
    click_button('Submit')
    expect(page).to have_link('Facebook', href: 'https://facebook.com')
  end
end
