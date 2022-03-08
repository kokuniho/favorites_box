class ItemComment < ApplicationRecord
  
  belongs_to :end_user
  belongs_to :item
  validates :comment, presence: true
end
