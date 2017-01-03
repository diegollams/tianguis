require 'rails_helper'

feature 'Visitor enters ' do
  scenario 'sees tianguis header ' do
    visit root_path
    expect(page).to have_content 'Tianguis'
  end
end