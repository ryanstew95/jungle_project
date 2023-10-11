class User < ApplicationRecord
  has_secure_password
  validates :email, uniqueness: { case_sensitive: false }, presence:true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, presence: true, length: { minimum: 4 }
  def self.authenticate_with_credentials(email, password)
    user = User.find_by(email: email.strip.downcase)
    user if user && user.authenticate(password)
  end
end
