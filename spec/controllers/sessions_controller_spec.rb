require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe "GET #new" do
    it "renders new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "GET #create" do
    context 'success login' do
      before do
        @user = FactoryGirl.create(:user)
        post :create, params: {email: @user.email, password: 'secret'}
      end

      it 'redirects to root_path' do
        expect(response).to redirect_to root_path
      end

      it 'sets session user_id' do
        expect(session[:user_id]).to eq @user.id
      end

      it { is_expected.to set_flash }
    end

    context 'invalid login' do
      before do
        @user = FactoryGirl.create(:user)
        post :create, params: {email: @user.email, password: 'bad_password'}
      end

      it 'redirects to /login' do
        expect(response).to redirect_to login_path
      end

      it { is_expected.to set_flash }
    end
  end

  describe "GET #destroy" do
    it "redirects to root path" do
      get :destroy
      expect(response).to redirect_to root_path
    end

    it 'removes user_id from session' do
      @user = FactoryGirl.create(:user)
      post :create, params: {email: @user.email, password: 'secret'}
      expect(session[:user_id]).to eq @user.id
      get :destroy
      expect(session[:user_id]).to be_nil
    end
  end

end
