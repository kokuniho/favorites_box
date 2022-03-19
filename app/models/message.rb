class Message < ApplicationRecord
  # 空で送信しない
  validates :message, presence: true
  belongs_to :end_user, optional: true
  belongs_to :room, optional: true
  has_many :notifications, dependent: :destroy
end
