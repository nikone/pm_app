FactoryGirl.define do
  factory :user do
    username { Faker::Name.first_name + Faker::Name.last_name }
    email { Faker::Internet.email }
    password 'somerandompass'
    password_confirmation 'somerandompass'
    current_sign_in_ip '127.0.0.1'
  end
end