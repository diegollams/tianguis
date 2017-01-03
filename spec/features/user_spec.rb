require 'rails_helper'

feature 'User signup' do
  scenario 'adds a valid user' do
    user = FactoryGirl.build(:user)
    visit signup_path
    expect{
      fill_in 'User name', with: user.user_name
      fill_in 'Email', with: user.email

      find('#user_password').set(user.password)
      find('#user_password_confirmation').set(user.password_confirmation)
      click_button 'Create User'
    }.to change(User, :count).by(1)
    expect(current_path).to eq root_path
    expect(page).to have_content 'User created'
  end

  scenario 'adds an invalid user' do
    user = FactoryGirl.build(:blank_user, email: 'adada', password: '1234', password_confirmation: '6543')
    visit signup_path
    expect{
      fill_in 'User name', with: user.user_name
      fill_in 'Email', with: user.email

      find('#user_password').set(user.password)
      find('#user_password_confirmation').set(user.password_confirmation)
      click_button 'Create User'
    }.to_not change(User, :count)
    expect(current_path).to eq signup_path
    expect(page).to have_content 'Invalid user'
    expect(page).to have_content 'is invalid'
    expect(page).to have_content "doesn't match Password"
    expect(page).to have_content 'is too short (minimum is 6 characters)'
  end
end