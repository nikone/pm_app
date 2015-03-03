FactoryGirl.define do
  factory :board do
    title { Faker::Lorem.word }

    factory :board_with_tasks do
      after(:create) do |board|
        6.times { board.tasks << create(:task_with_tags) }
      end
    end
  end  
end