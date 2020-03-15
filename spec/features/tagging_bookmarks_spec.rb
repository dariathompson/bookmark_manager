# frozen_string_literal: true

feature 'tag a bookmark' do
  feature 'a user can add and then view a tag' do
    scenario 'a comment is added to a bookmark' do
      bookmark = Bookmark.create(url: 'https://facebook.com', title: 'Facebook')

      visit '/bookmarks'
      first('.bookmark').click_button 'Add Tag'

      expect(current_path).to eq "/bookmarks/#{bookmark.id}/tags/new"

      fill_in 'tag', with: 'test tag'
      click_button 'Submit'

      expect(current_path).to eq '/bookmarks'
      expect(first('.bookmark')).to have_content 'test tag'
    end
  end

  feature 'a user can filter bookmarks by tag' do
    scenario 'adding the same tag to multiple bookmarks then filtering by tag' do
      Bookmark.create(url: 'https://makers.tech', title: 'Makers Academy')
      Bookmark.create(url: 'https://www.destroyallsoftware.com', title: 'Destroy All Software')
      Bookmark.create(url: 'https://google.com', title: 'Google')

      visit('/bookmarks')

      within page.find('.bookmark:nth-of-type(1)') do
        click_button 'Add Tag'
      end
      fill_in 'tag', with: 'testing'
      click_button 'Submit'

      within page.find('.bookmark:nth-of-type(2)') do
        click_button 'Add Tag'
      end
      fill_in 'tag', with: 'testing'
      click_button 'Submit'

      first('.bookmark').click_link 'testing'

      expect(page).to have_link 'Makers Academy', href: 'https://makers.tech'
      expect(page).to have_link 'Destroy All Software',  href: 'https://www.destroyallsoftware.com'
      expect(page).not_to have_link 'Google', href: 'https://google.com'
    end
  end
end
