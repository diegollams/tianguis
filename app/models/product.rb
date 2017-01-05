class Product < ApplicationRecord
  belongs_to :user
  validates :name, :price, :image_url, :user_id, presence: true
  validates :price, numericality: { greater_than: 0 }
  validate :only_3_for_day

  def only_3_for_day
    return if user.products.count < 3
    last = user.products.limit(3).order(created_at: :desc).last
    if Date.today === last.created_at.to_date
      errors[:base] << 'You already create 3 products today'
    end
  end
end
