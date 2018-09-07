class Post < ApplicationRecord
  belongs_to :postable, polymorphic: true
  has_many :comments
  self.per_page = 5
  validates :title, length: {
    minimum: 3
  }
  validates :body, length: {
    minimum: 100
  }
  validates :categories, presence: true
end
