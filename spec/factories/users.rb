FactoryGirl.define do
  factory :user do
    sequence(:first_name) {Faker::Name.first_name}
    sequence(:last_name) {Faker::Name.last_name}
    sequence(:email) { |n| Faker::Internet.email.gsub('@', "-#{n}@")}
    password '123'
  end
end
