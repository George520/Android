class Message < ActiveRecord::Base
  validates :content, length: {
    minimum: 10}
  belongs_to :user
end
