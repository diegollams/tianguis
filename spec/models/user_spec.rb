require 'rails_helper'

RSpec.describe User, type: :model do
 context 'password' do
    it 'is invalid without password' do
      user = FactoryGirl.build(:blank_user)
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end

    it 'is invalid without password_confirmation' do
      user = FactoryGirl.build(:blank_user)
      user.valid?
      expect(user.errors[:password_confirmation]).to include("can't be blank")
    end

    it 'is invalid if password and password_confirmation not match' do
      user = FactoryGirl.build(:user, password: 'secret', password_confirmation: 'nosecret')
      user.valid?
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end

    it 'is invalid with a password size of less tha 6' do
      user = FactoryGirl.build(:user, password: '12345')
      user.valid?
      expect(user.errors[:password]).to include('is too short (minimum is 6 characters)')
    end
  end

  context 'email' do
    it 'is invalid without email' do
      user = FactoryGirl.build(:blank_user)
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    it 'is invalid without email format' do
      user = FactoryGirl.build(:user, email: 'inavlid.com')
      user.valid?
      expect(user.errors[:email]).to include('is invalid')
    end

    it 'is invalid with a duplicated email' do
      FactoryGirl.create(:user, email: 'test@mail.com')
      user = FactoryGirl.build(:user, email: 'test@mail.com')
      user.valid?
      expect(user.errors[:email]).to include('has already been taken')
    end
  end

  context 'user_name' do
    it 'is invalid without user_name' do
      user = FactoryGirl.build(:blank_user)
      user.valid?
      expect(user.errors[:user_name]).to include("can't be blank")
    end

    it 'is invalid with a duplicated user_name' do
      FactoryGirl.create(:user, user_name: 'test')
      user = FactoryGirl.build(:user, user_name: 'test')
      user.valid?
      expect(user.errors[:user_name]).to include('has already been taken')
    end

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
