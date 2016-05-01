FactoryGirl.define do
  factory :player do
    sequence(:email) { |n| "player#{n}@chesswithfriends.test" }
    sequence(:username) { |n| "player#{n}" }
    password("password")
  end
end
