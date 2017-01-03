FactoryGirl.define do
  factory :user do
    user_name Faker::Internet.user_name
    email Faker::Internet.email
    password 'secret'
    password_confirmation 'secret'
  end
end
