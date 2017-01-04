require 'rails_helper'

RSpec.describe Product, type: :model do
  it { is_expected.to validate_presence_of(:name) }

  it { is_expected.to validate_presence_of(:price) }

  it { is_expected.to validate_presence_of(:image_url) }

  it { is_expected.to validate_presence_of(:user_id) }

  it { is_expected.to validate_numericality_of(:price).is_greater_than(0) }

  it { is_expected.to belong_to(:user) }

end
