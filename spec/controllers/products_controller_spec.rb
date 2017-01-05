require 'rails_helper'


RSpec.describe ProductsController, type: :controller do

  before { @user = FactoryGirl.create(:user)}

  let(:valid_session) { {user_id: @user.id} }

  describe "GET #index" do
    it "assigns all products as @products" do
      product = FactoryGirl.create(:product, user_id: @user.id)
      get :index, params: {}, session: valid_session
      expect(assigns(:products)).to eq([product])
    end
  end

  describe "GET #show" do
    it "assigns the requested product as @product" do
      product = FactoryGirl.create(:product, user_id: @user.id)
      get :show, params: {id: product.to_param}, session: valid_session
      expect(assigns(:product)).to eq(product)
    end
  end
end
