class User < ApplicationRecord
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

  # returns the hash digest of the given string
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
    BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
