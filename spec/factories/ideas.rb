FactoryGirl.define do
  factory :idea do
    association :user, factory: :user
    sequence(:title) { |n| Faker::Commerce.product_name + "#{n}"}
    description Faker::Hacker.say_something_smart
    member_count 1
    like_count 1
  end
end
