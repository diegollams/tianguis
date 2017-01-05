class UserMailer < ApplicationMailer
  default from: 'sigup@mail.com'

  def signup(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome')
  end
end