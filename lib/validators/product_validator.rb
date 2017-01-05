class ProductValidator
  attr_accessor :product
  def initialize(product, limit = 3)
    @product = product
    @limit = limit
    @save = false
  end

  def create
    if less_than_limit_for_today && @product.save
      @save = true
      return @product
    end
    @save = false
    @product
  end

  def saved?
    @save
  end


  private
    def less_than_limit_for_today
      # if user is nil let validator save and this will adds normal product errors
      return true if @product.user.nil? || @product.user.products.count < @limit
      last = @product.user.products.limit(@limit).order(created_at: :desc).first
      if Date.today === last.created_at.to_date
        @product.errors[:base] << "You already create #{@limit} products today"
        false
      else
        true
      end
    end
end
