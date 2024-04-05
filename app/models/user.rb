class User < ApplicationRecord
  attr_accessor :remember_token

  before_save { email.downcase! }
  # la línea anterior se pudo haber expresado como
  # self.email = self.email.downcase # where "self" refers to the current user
  validates :name, presence: true, length: { maximum: 50 }
  # validates es un método por lo que válidamente se puede escribir
  # validates(:name, presence: true)
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: true
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  # Returns the hash digest of the given string
  def self.digest(string) # esto es lo mismo que User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
    BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token
  def self.new_token # esto es lo mismo que User.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user un the database for use in persistent sessions
  def remember # user = User.first => user.remeber
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
    remember_digest
  end

  # Returns true if the given token matches the digest
  def authenticated?(remember_token)
    return false if remember_digest.nil?

    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Returns a session token to prevent session hijacking
  # We reuse the remember digest for convenience
  def session_token
    remember_digest || remember
  end
end
