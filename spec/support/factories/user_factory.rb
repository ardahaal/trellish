FactoryBot.define do
  factory :user do
    name { FFaker::Name.name }
    email { FFaker::Internet.email }
    password do
      (('A'..'Z').to_a.sample(4) + ('a'..'z').to_a.sample(4) + (10..99).to_a.sample(2)).join
    end
  end
end
