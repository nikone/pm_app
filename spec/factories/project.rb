FactoryGirl.define do
  factory :project do
    title { Faker::Lorem.words(3).join(" ") }
    description { Faker::Lorem.sentences(4).join(" ") }

    factory :project_with_board do
      after(:create) do |project|
        project.boards << create(:board)
      end
    end

    factory :project_with_tasks do
      after(:create) do |project|
        project.boards << create(:board_with_task)
      end
    end
  end
end