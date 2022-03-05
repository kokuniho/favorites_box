class Item < ApplicationRecord
   has_one_attached :image
   belongs_to :end_user
   has_many :item_tags, dependent: :destroy
   has_many :tags, through: :item_tags

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end
end
