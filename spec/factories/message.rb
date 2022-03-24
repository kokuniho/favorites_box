FactoryBot.define do
  factory :message do
    message { Faker::Lorem.characters(number:10) }
  end
end