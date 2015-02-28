FactoryGirl.define do
  factory :company do
    name { Faker::Lorem.words(2).join(" ") }
  end
end