require 'rails_helper'
require 'rack_session_access/capybara'
feature 'User products' do
  before(:each) do
    @user = FactoryGirl.create(:user)
    page.set_rack_session(user_id: @user.id)
  end

  def visits_and_fill_product(path, button_text)
    visit path
    product = FactoryGirl.build(:product, user: @user)
    fill_in 'Name', with: product.name
    fill_in 'Description',with: product.description
    fill_in 'Price',with: product.price
    fill_in 'Image url', with: product.image_url
    click_button button_text
  end

  scenario 'enter user products index and a product' do
    product = FactoryGirl.create(:product, user: @user)
    visit user_products_path(@user)
    expect(page).to have_content product.name
    click_link product.name
    expect(current_path).to eq user_product_path(@user, product)
  end

  scenario 'enters and create 4 products' do
    3.times do
      visits_and_fill_product(new_user_product_path(@user), 'Create Product')
      product = Product.last
      expect(current_path).to eq user_product_path(@user, product)
      expect(page).to have_content product.name
    end
    visits_and_fill_product(new_user_product_path(@user), 'Create Product')
    expect(page).to have_content 'You already create 3 products today'
  end

  scenario 'enters and edit product' do
    product = FactoryGirl.create(:product, user: @user)
    visits_and_fill_product(edit_user_product_path(@user, product), 'Update Product')
    expect(page).to have_content 'Product was successfully updated.'
  end

end