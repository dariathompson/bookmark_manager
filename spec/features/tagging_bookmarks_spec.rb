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
end