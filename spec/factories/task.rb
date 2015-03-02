FactoryGirl.define do
  factory :task do
    title { Faker::Lorem.word }
    description { Faker::Lorem.sentences(4).join(" ") }
    association :creator, factory: :user
    association :assignee, factory: :user
  end
end