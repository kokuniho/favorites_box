FactoryBot.define do
  factory :item_comment do
    comment { Faker::Lorem.characters(number:10)}
    association :end_user
    association :item
  end
end
