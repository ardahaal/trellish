FactoryBot.define do
  factory :task do
    title { FFaker::Lorem.phrase }
    description { FFaker::Lorem.paragraph }
    association :list
  end
end
