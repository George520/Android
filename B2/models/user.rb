class User < ActiveRecord::Base
  validates :username, length: {
    minimum: 3,
    maximum: 20
  }, presence: true,
  uniqueness: true
  validates :password, format: {
  with: /\A[a-zA-Z0-9!@#\$%^&\(\)]+\z/,
  message: "only allows a-z, 0-9 and !@#$%^&*()"
}
  has_many :message
  has_secure_password
end
