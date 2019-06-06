class Entry < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, length: {maximum: 100}
  validates :content, length:{maximum:250}

  scope :recent, ->{order(created_at: :DESC)}
end
