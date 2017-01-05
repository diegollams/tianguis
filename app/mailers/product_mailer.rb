class ProductMailer < ApplicationMailer
  default from: 'juan@mail.com'

  def new_product(user, product)
    @user = user
    @product = product
    puts 'cca'
    mail(to: @user.email, subject: "New product #{@product.name}")
  end
end