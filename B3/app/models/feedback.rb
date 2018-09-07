class Feedback < ApplicationRecord
  belongs_to :user
  self.per_page = 5
  validates :content, length: {
    minimum: 5
  }
end
