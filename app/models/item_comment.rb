class ItemComment < ApplicationRecord
  belongs_to :end_user
  belongs_to :item
  has_many :notifications, dependent: :destroy
  validates :comment, presence: true, length: { maximum: 100 }
end
