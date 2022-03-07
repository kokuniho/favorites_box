class Favorite < ApplicationRecord
  belongs_to :end_user
  belongs_to :item
  validates_uniqueness_of :item_id, scope: :end_user_id
  
end
