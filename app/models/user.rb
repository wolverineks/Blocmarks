class User < ActiveRecord::Base
  has_many :topics
  attr_accessor :password
  before_save :encrypt_password

  validates :email, presence: true
  validates :password, presence: true, confirmation: true
  validates :password_confirmation, presence: true

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

end
