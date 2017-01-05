class Users::ProductsController < ApplicationController
  require 'product_validator'
  before_action :authorize
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :find_user

  def index
    @products = @user.products
  end

  def show
  end

  def new
    @product = Product.new
  end

  def edit
  end

  def create
    product = Product.new(product_params)
    product.user = @user
    product_validator = ProductValidator.new(product)
    @product = product_validator.create
    if product_validator.saved?
      puts @product.id
      redirect_to user_product_path(@user, @product), notice: 'Product was successfully created.'
    else
      render :new
    end
  end

  def update
    if @product.update(product_params)
      redirect_to user_product_path(@user, @product), notice: 'Product was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to users_products_url, notice: 'Product was successfully destroyed.'
  end

  private
    def find_user
      @user = User.find(params[:user_id])
      redirect_to user_products_path(current_user) if current_user.id != @user.id
    end

    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :description, :price, :image_url)
    end
end
