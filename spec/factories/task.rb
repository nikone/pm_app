FactoryGirl.define do
  factory :task do
    title { Faker::Lorem.word }
    description { Faker::Lorem.sentences(4).join(" ") }
    association :creator, factory: :user
    association :assignee, factory: :user
    association :board, factory: :board

    factory :task_with_tags do
      after(:create) do |task|
        2.times { task.tags << create(:tag) }
      end
    end
  end
end