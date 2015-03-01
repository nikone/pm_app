FactoryGirl.define do
  factory :task do
    title { Faker::Lorem.word }
    association :creator, factory: :user
    association :assignee, factory: :user
  end
end