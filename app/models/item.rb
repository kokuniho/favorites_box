class Item < ApplicationRecord
   has_one_attached :image
   belongs_to :end_user
   has_many :item_tags, dependent: :destroy
   has_many :tags, through: :item_tags
   has_many :favorites, dependent: :destroy
   has_many :item_comments, dependent: :destroy
   
   

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/logo2.png')
      image.attach(io: File.open(file_path), filename: 'default-image.png', content_type: 'image/png')
    end
    image
  end

  def favorited_by?(end_user)
    favorites.exists?(end_user_id: end_user.id)
  end

end
