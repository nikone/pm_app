FactoryGirl.define do
  factory :project do
    title { Faker::Lorem.words(3).join(" ") }
    description { Faker::Lorem.sentences(4).join(" ") }

    factory :project_with_boards do
      after(:create) do |project|
        4.times { project.boards << create(:board_with_tasks) }
      end
    end
  end
end