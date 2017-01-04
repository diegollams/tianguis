require 'rails_helper'

RSpec.describe User, type: :model do
 context 'password' do
    it { is_expected.to validate_presence_of(:password) }

    it { is_expected.to validate_presence_of(:password_confirmation) }

    it 'is invalid if password and password_confirmation not match' do
      user = FactoryGirl.build(:user, password: 'secret', password_confirmation: 'nosecret')
      user.valid?
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end

    it { is_expected.to have_secure_password }

    it { is_expected.to validate_length_of(:password).is_at_least(6) }
  end

  context 'email' do
    it { is_expected.to validate_presence_of(:email) }

    it 'is invalid without email format' do
      user = FactoryGirl.build(:user, email: 'inavlid.com')
      user.valid?
      expect(user.errors[:email]).to include('is invalid')
    end

    it { is_expected.to validate_uniqueness_of(:email) }
  end

  context 'user_name' do
    it { is_expected.to validate_presence_of(:user_name) }

    it{ is_expected.to validate_uniqueness_of(:user_name)}

    it 'is invalid with a space in user_name' do
      user = FactoryGirl.build(:user, user_name: 'test space')
      user.valid?
      expect(user.errors[:user_name]).to include('is invalid')
    end
  end

  it 'is valid with user_name, email and password' do
    expect(FactoryGirl.build(:user).valid?).to be true
  end
end
