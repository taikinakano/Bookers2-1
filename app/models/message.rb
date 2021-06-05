class Message < ApplicationRecord
  validates :content, presence: true
  belongs_to :user
  belongs_to :room

validates :content,    length: { maximum: 140 }
end
