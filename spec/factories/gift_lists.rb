FactoryBot.define do
  factory :gift_list do
    title { Faker::Lorem.word }
    text { Faker::Lorem.paragraph }
  end
end