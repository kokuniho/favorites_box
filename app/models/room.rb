class Room < ApplicationRecord
  has_many :entries, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :notifications, dependent: :destroy

  # def create_notification_comment(current_end_user, message_id)
  #   receiver = Entry.where(room_id: id).where.not(end_user_id: current_end_user.id).find_by(room_id: id)
  #   save_notification_comment(current_end_user, message_id, receiver.end_user_id)
  # end

  # def save_notification_comment(current_end_user, message_id, visited_id)
  #   notification = current_end_user.active_notifications.new(
  #           visited_id: visited_id,
  #           visitor_id: current_end_user.id,
  #           room_id: id,
  #           message_id: message_id,
  #           action: 'dm'
  #         )
  #   notification.save if notification.valid?
  # end
end
