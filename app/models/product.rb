class Product < ApplicationRecord
  belongs_to :user
  validates :name, :price, :image_url, :user_id, presence: true
  validates :price, numericality: { greater_than: 0 }

end
