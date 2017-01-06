require 'rails_helper'

RSpec.describe Users::ProductsController, type: :controller do

  before do
    @user = FactoryGirl.create(:user)
    @product = FactoryGirl.create(:product, user: @user)
  end

  let(:valid_session) { {user_id: @user.id} }

  describe 'GET #index' do
    it 'assigns all users_products as @user' do
      get :index, params: {user_id: @user.id, id: @product.id}, session: valid_session
      expect(assigns(:products)).to eq([@product])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested users_product as @users_product' do
      get :show, params: {user_id: @user.id, id: @product.to_param}, session: valid_session
      expect(assigns(:product)).to eq(@product)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Users::Product' do
        expect {
          post :create, params: {user_id: @user.id, product: FactoryGirl.attributes_for(:product)}, session: valid_session
        }.to change(Product, :count).by(1)
      end

      it 'assigns a newly created product as @product' do
        post :create, params: {user_id: @user.id, product: FactoryGirl.attributes_for(:product)}, session: valid_session
        expect(assigns(:product)).to be_a(Product)
        expect(assigns(:product)).to be_persisted
      end

      it 'redirects to the created users_product' do
        post :create, params: {user_id: @user.id, product: FactoryGirl.attributes_for(:product)}, session: valid_session
        expect(response).to redirect_to user_product_path(@user, Product.last)
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved users_product as @users_product' do
        post :create, params: {user_id: @user.id, product: FactoryGirl.attributes_for(:blank_user)}, session: valid_session
        expect(assigns(:product)).to be_a_new(Product)
      end

      it 're-renders the :new template' do
        post :create, params: {user_id: @user.id, product: FactoryGirl.attributes_for(:blank_product)}, session: valid_session
        expect(response).to render_template("new")
      end
    end
  end
  
end
