FactoryBot.define do
  factory :list do
    name { FFaker::Lorem.phrase }
  end

  factory :archived_list, class: List do
    name { FFaker::Lorem.phrase }
    status "archived"
  end
end
