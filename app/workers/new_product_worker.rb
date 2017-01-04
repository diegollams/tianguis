class NewProductWorker
  include Sidekiq::Worker
  def perform(user_id, product_id)
    user_owner = User.find user_id
    product = Product.find product_id
    User.all.each do |user|
      next if user_owner.id == user.id
      ProductMailer.new_product(user, product)
    end
  end
end