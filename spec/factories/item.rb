FactoryBot.define do
  factory :item do
    name { Faker::Lorem.characters(number:5) }
    body { Faker::Lorem.characters(number:30) }
  end
end