class Favorite < ApplicationRecord
  belongs_to :end_user, optional: true
  belongs_to :item, optional: true
  validates_uniqueness_of :item_id, scope: :end_user_id

end
