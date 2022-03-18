class Entry < ApplicationRecord
  belongs_to :room, optional: true
  belongs_to :end_user, optional: true
end
