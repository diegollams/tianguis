FactoryGirl.define do
  factory :user do
    sequence(:user_name) { |n| "user_#{n}" }
    sequence(:email) { |n| "person#{n}@example.com" }
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
