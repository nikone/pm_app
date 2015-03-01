FactoryGirl.define do
  factory :board do
    title { Faker::Lorem.word }

    factory :board_with_tasks do
      after(:create) do |board|
        3.times { board.tasks << create(:task) }
      end
    end
  end  
end