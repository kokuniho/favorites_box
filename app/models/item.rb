class Item < ApplicationRecord
  has_one_attached :image
  belongs_to :end_user
  has_many :item_tags, dependent: :destroy
  has_many :tags, through: :item_tags
  has_many :favorites, dependent: :destroy
  has_many :week_favorites, -> { where(created_at: ((Time.current.at_end_of_day - 6.day).at_beginning_of_day)..(Time.current.at_end_of_day)) }, class_name: 'Favorite'
  has_many :item_comments, dependent: :destroy
  has_many :notifications, dependent: :destroy

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/logo2.png')
      image.attach(io: File.open(file_path), filename: 'default-image.png', content_type: 'image/png')
    end
    image
  end

  def favorited_by?(end_user)
    favorites.where(end_user_id: end_user.id).exists?
  end

  def create_notification_by(current_end_user)
    notification = current_end_user.active_notifications.new(
      item_id: id,
      visited_id: end_user_id,
      action: "favorite"
    )
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

  def create_notification_comment!(current_end_user, item_comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = ItemComment.select(:end_user_id).where(item_id: id).where.not(end_user_id: current_end_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_end_user, item_comment_id, temp_id['end_user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_comment!(current_end_user, item_comment_id, end_user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_end_user, item_comment_id, visited_id)
    # コメントは複数回するため、１つの投稿に複数回通知する
    notification = current_end_user.active_notifications.new(
      item_id: id,
      item_comment_id: item_comment_id,
      visited_id: visited_id,
      action: 'item_comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
        notification.save if notification.valid?
  end
end
