FactoryBot.define do
  factory :user do
    name { FFaker::Name.name }
    email { FFaker::Internet.email }
    password do
      (('A'..'Z').to_a.sample(4) + ('a'..'z').to_a.sample(4) + (10..99).to_a.sample(2)).join
    end

    trait :with_assignments do
      transient do
        number_of_tasks 1
      end

      after(:create) do |u, evaluator|
        list = create(:list)
        tasks = create_list(:task, evaluator.number_of_tasks, list: list)
        tasks.each { |t| u.assignments << create(:assignment, user: u, task: t) }
        u.save
      end
    end
  end
end
