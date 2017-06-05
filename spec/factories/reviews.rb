FactoryGirl.define do
  factory :review do
    association :user, factory: :user
    association :idea, factory: :idea

    body Faker::Hacker.say_something_smart
  end

end
