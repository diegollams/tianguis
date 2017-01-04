
class SignupMailerWorker
  include Sidekiq::Worker
  def perform(user_id)
    user = User.find(user_id)
    UserMailer.signup(user)
  end
end