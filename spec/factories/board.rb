FactoryGirl.define do
  factory :board do
    title { Faker::Lorem.word }
    association :project, factory: :project

    factory :board_with_tasks do
      after(:create) do |board|
        2.times { board.tasks << create(:task_with_tags) }
      end
    end
  end  
end