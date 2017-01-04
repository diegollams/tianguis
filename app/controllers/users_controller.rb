class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = 'User created'
      redirect_to root_path, notice: ''
      SignupMailerWorker.perform_async(@user.id)
    else
      flash[:alert] = 'Invalid user'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :email, :password, :password_confirmation)
  end

end
