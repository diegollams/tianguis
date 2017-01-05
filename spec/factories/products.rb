FactoryGirl.define do
  factory :product do
    name Faker::Beer.name
    description Faker::Beer.style
    image_url "MyString"
    price 9.99
    user
    # association :user, factory: :user
  end
end
