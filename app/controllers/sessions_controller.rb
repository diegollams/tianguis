class SessionsController < ApplicationController
  def new
  end

  def create
    user =  User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = 'User login'
      redirect_to root_path
    else
      flash[:alert] = 'Invalid login'
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
