class Message < ApplicationRecord
  # 空で送信しない
  validates :message, presence: true, length: { maximum: 200 }
  belongs_to :end_user, optional: true
  belongs_to :room, optional: true
  has_many :notifications, dependent: :destroy
end
