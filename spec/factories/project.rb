FactoryGirl.define do
  factory :project do
    title { Faker::Lorem.words(3).join(" ") }
    description { Faker::Lorem.sentences(4).join(" ") }
  end
end