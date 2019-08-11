FactoryBot.define do
  factory :gift do
    title { Faker::Lorem.word }
    text { Faker::Lorem.paragraph }
  end
end