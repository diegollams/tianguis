class User < ApplicationRecord
  has_secure_password
  validates :user_name, :email, :password, :password_confirmation, presence: true
  validates :user_name, :email, uniqueness: true
  validates_length_of :password, minimum: 6
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates :user_name, format: { without: /\s/ }
  has_many :products
end
