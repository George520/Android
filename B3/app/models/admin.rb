class Admin < ApplicationRecord
  has_many :posts, as: :postable
  has_secure_password
  self.per_page = 5
  validates :admin_name, length: {
    minimum: 3,
    maximum: 20
  }, presence: true,
  uniqueness: true

  validates :password, format: {
  with: /\A[a-zA-Z0-9!@#\$%^&\(\)]+\z/,
  message: "密码只能含有以下字符： a-z, 0-9 and !@#$%^&*()"
},
presence: true

end
