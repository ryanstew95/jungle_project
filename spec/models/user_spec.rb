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
  password_confirmation: 'password',
  first_name: 'John',
  last_name: 'Doe'
)
expect(user).to be_valid
  end
  it 'is invalid with a non-unique email' do
    User.create(
      email: 'test@test.com',
      password: 'password',
      password_confirmation: 'password',
      first_name: 'John',
      last_name: 'Doe'
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
  it 'is invalid without first name' do
    user = User.new(
      email: 'john@example.com',
      password: 'password',
      password_confirmation: 'password',
      first_name: nil,
      last_name: 'Doe'
    )
    expect(user).not_to be_valid
    expect(user.errors.full_messages).to include("First name can't be blank")
  end  

  it 'is invalid without last name' do
    user = User.new(
      email: 'john@example.com',
      password: 'password',
      password_confirmation: 'password',
      first_name: 'John',
      last_name: nil
    )
    expect(user).not_to be_valid
    expect(user.errors.full_messages).to include("Last name can't be blank")
  end  

  it 'is invalid if password is less than four characters' do
    user = User.new(
      email: 'john@example.com',
      password: '123',
      password_confirmation: '123',
      first_name: 'John',
      last_name: 'Doe'
    )
    expect(user).not_to be_valid
    expect(user.errors.full_messages).to include("Password is too short (minimum is 4 characters)")
  end  
  describe '.authenticate_with_credentials' do
    def create_user(email, password)
      User.create(
        email: email,
        password: password,
        password_confirmation: password,
        first_name: 'John',
        last_name: 'Doe'
      )
    end
    it 'returns nil if authentication fails' do
      user = create_user('test@example.com', 'password123')
      authenticated_user = User.authenticate_with_credentials('test@example.com', 'wrong_password')
      expect(authenticated_user).to be_nil
    end
    it 'ignores leading and trailing whitespaces in email' do
      user = create_user('test@example.com', 'password123')
      authenticated_user = User.authenticate_with_credentials('  test@example.com  ', 'password123')
      expect(authenticated_user).to eq(user)
    end

    it 'is case-insensitive for email' do
      user = create_user('test@example.com', 'password123')
      authenticated_user = User.authenticate_with_credentials('TEST@example.com', 'password123')
      expect(authenticated_user).to eq(user)
    end
  end
end
