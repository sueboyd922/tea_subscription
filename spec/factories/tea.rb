FactoryBot.define do
  factory :tea do
    name { Faker::Tea.variety }
    description { Faker::Hipster.sentence }
    brew_time { Faker::Number.between(from: 2, to: 15) }
    temperature { Faker::Number.between(from: 30, to: 100) }
  end
end
