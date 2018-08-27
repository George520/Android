class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  self.per_page = 10
  validates :message, length: {
    minimum: 3
  }
end
