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

      describe 'same request' do
        before {post :create, params: {user: FactoryGirl.attributes_for(:user)}}

        it 'redirect to root_path' do
          expect(response).to redirect_to root_path
        end

        it 'adds flash[:success]' do
          expect(flash[:success]).to eq 'User created'
        end

        it { is_expected.to set_session }
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new user in the database' do
        expect{
          post :create, params: {user: FactoryGirl.attributes_for(:blank_user)}
        }.not_to change(User, :count)
      end

      describe 'same request' do
        before { post :create, params: {user: FactoryGirl.attributes_for(:blank_user)} }
        it 'renders the n :new template' do
          expect(response).to render_template :new
        end

        it 'add flash[:notice]' do
          expect(flash[:alert]).to eq 'Invalid user'
        end

        it 'not set user id in session' do
          expect(session[:user_ud]).to be_nil
        end

      end
    end
  end
end
