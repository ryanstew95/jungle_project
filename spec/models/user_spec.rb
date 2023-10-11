require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'is invalid if password and password confirmation do not match' do
    user = User.new(
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'different_password'
      )
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
  end
  it 'is valid when passwords match' do
user = User.new(
  email: 'test@example.com',
  password: 'password',
  password_confirmation: 'password'
)
expect(user).to be_valid
  end
  it 'is invalid with a non-unique email' do
    User.create(
      email: 'test@test.com',
      password: 'password',
      password_confirmation: 'password'
    )
    user = User.new(
      email: 'TEST@TEST.com',
      password: 'password',
      password_confirmation: 'password'
    )
    expect(user).not_to be_valid
    expect(user.errors.full_messages).to include('Email has already been taken')
  end
  
  it 'is valid with valid attributes' do
    user = User.new(
      email: 'john@example.com',
      password: 'password',
      password_confirmation: 'password',
      first_name: 'John',
      last_name: 'Doe'
    )
    expect(user).to be_valid
  end
  it 'is invalid without an email' do
    user = User.new(
      email: nil,
      password: 'password',
      password_confirmation: 'password',
      first_name: 'John',
      last_name: 'Doe'
    )
    expect(user).not_to be_valid
    expect(user.errors.full_messages).to include("Email can't be blank")
  end
end
