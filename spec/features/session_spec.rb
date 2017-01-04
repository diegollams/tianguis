require 'rails_helper'

feature 'Session signin' do
  before { @user = FactoryGirl.create(:user)}
  scenario 'valid user login' do
    visit login_path
    find('#email').set(@user.email)
    find('#password').set('secret')
    click_button 'Submit'
    expect(current_path).to eq root_path
    expect(page).to have_content 'User login'
  end

  scenario 'invalid user login' do
    visit login_path
    find('#email').set(@user.email)
    find('#password').set('bad_password')
    click_button 'Submit'
    expect(current_path).to eq login_path
    expect(page).to have_content 'Invalid login'
  end
end