require 'rails_helper'

RSpec.describe UserController, type: :controller do


  describe 'GET #new' do
    it 'renders the :show template' do
      get :new
      expect(response).to render_template(:new)
    end

    it 'assings a new user to @user' do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe 'Post #create' do
    context 'with valid attributes' do
      it 'saves the user to the database' do
        expect{
          post :create, params: {user: FactoryGirl.attributes_for(:user)}
        }.to change(User, :count).by(1)
      end

      it 'redirect to root_path' do
        post :create, params: {user: FactoryGirl.attributes_for(:user)}
        expect(response).to redirect_to root_path
      end

      it 'adds flash[:success]' do
        post :create, params: {user: FactoryGirl.attributes_for(:user)}
        expect(flash[:success]).to eq 'User created'
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new user in the database' do
        expect{
          post :create, params: {user: FactoryGirl.attributes_for(:blank_user)}
        }.not_to change(User, :count)
      end

      it 'renders the n :new template' do
        post :create, params: {user: FactoryGirl.attributes_for(:blank_user)}
        expect(response).to render_template :new
      end

      it 'add flash[:notice]' do
        post :create, params: {user: FactoryGirl.attributes_for(:blank_user)}
        expect(flash[:alert]).to eq 'Invalid user'
      end
    end
  end
end
