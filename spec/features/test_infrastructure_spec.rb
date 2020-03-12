# frozen_string_literal: true

feature 'test infrastructure' do
  scenario 'says Hello World' do
    visit '/'
    expect(page).to have_content 'Hello World'
  end
end
