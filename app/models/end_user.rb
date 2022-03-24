class EndUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items, dependent: :destroy
  has_one_attached :profile_image
  # foreign_key（FK）には、@user.xxxとした際に「@user.idがfollower_idなのかfollowed_idなのか」を指定します。
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # @end_user.itemsのように、@end_user.yyyで、
  # そのユーザがフォローしている人orフォローされている人の一覧を出したい
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower
  has_many :favorites, dependent: :destroy
  has_many :item_comments, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy
  has_many :view_counts, dependent: :destroy



  def get_profile_image(width, height)
  unless profile_image.attached?
    file_path = Rails.root.join('app/assets/images/no_image.jpeg')
    profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
  end
  profile_image.variant(resize_to_limit: [width, height]).processed
  end

  # フォローしたときの処理
  def follow(end_user_id)
    relationships.create(followed_id: end_user_id)
  end
  #フォロー外す時
  def unfollow(end_user_id)
    relationships.find_by(followed_id: end_user_id).destroy
  end
  #フォローしてるか判定
  def following?(end_user)
    followings.include?(end_user)
  end

  def active_for_authentication?
    super && (is_deleted == false)
  end

  def create_notification_follow!(current_end_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ", current_end_user.id, id, 'follow' ])
    if temp.blank?
      notification = current_end_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
        )
    notification.save if notification.valid?
    end
  end
end
