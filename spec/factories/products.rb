FactoryGirl.define do
  factory :product do
    name Faker::Beer.name
    description Faker::Beer.style
    image_url "MyString"
    price 9.99
    user

    factory :blank_product do
      name nil
      description nil
      image_url nil
      price nil
      user
    end
  end
end
