require 'rails_helper'

RSpec.describe Product, type: :model do

  it { is_expected.to validate_presence_of(:name) }

  it { is_expected.to validate_presence_of(:price) }

  it { is_expected.to validate_presence_of(:image_url) }

  it { is_expected.to validate_presence_of(:user_id) }

  it { is_expected.to validate_numericality_of(:price).is_greater_than(0) }

  it { is_expected.to belong_to(:user) }

  # it 'is invalid if 3 products are created in the same day' do
  #   user = FactoryGirl.create(:user)
  #   expect{
  #     3.times do
  #       FactoryGirl.create(:product, user: user)
  #     end
  #   }.to change(Product, :count).by(3)
  #
  #   product = FactoryGirl.build(:product, user: user)
  #   product.valid?
  #   expect(product.errors[:base]).to include 'You already create 3 products today'
  # end

end
