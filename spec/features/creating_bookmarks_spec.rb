feature 'adding a new bookmark' do
  scenario 'user can add a new bookmark' do
    visit('/bookmarks/new')
    fill_in('url', with: 'https://facebook.com')
    click_button('Submit')
    expect(page).to have_content 'https://facebook.com'
  end
end