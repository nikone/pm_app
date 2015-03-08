FactoryGirl.define do
  factory :board do
    title { Faker::Lorem.word }

    factory :board_with_task do
      after(:create) do |board|
        board.tasks << create(:task)
      end
    end
  end  
end