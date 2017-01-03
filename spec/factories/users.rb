FactoryGirl.define do
  factory :user do
    user_name Faker::Internet.user_name
    email Faker::Internet.email
    password 'secret'
    password_confirmation 'secret'

    factory :blank_user do
      email nil
      user_name nil
      password nil
      password_confirmation nil
    end
  end
end
