class Comment < ApplicationRecord
  belongs_to :entry
  belongs_to :user

  validates :content, presence:true, length: {maximum: 160}

  scope :recent, -> { order(created_at: :DESC) }
end
