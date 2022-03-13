class Message < ApplicationRecord
  #空で送信しない
  validates :message, presence: true
  belongs_to :end_user
  belongs_to :room
end
