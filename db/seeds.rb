Review.destroy_all
Idea.destroy_all
User.destroy_all

admin_acc = User.create(first_name:'John', last_name:'Lam', email:'admin@admin.com', password:'123')
test_acc = User.create(first_name:'Nhoj', last_name:'Mal', email:'test@test.com', password:'123')

10.times do
  User.create(
  first_name:Faker::Name.first_name,
  last_name:Faker::Name.last_name,
  email:Faker::Internet.email,
  password: '123' )
end

users = User.all
puts "#{users.count} users created."

20.times do
  Idea.create(
  title: Faker::Hipster.sentence(3),
  description: Faker::Hipster.paragraph(3),
  user: users.sample,
  member_count: rand(1..25),
  like_count: rand(1..200)
  )
end

ideas = Idea.all
puts "#{ideas.count} ideas created."


ideas.each do |i|
  rand(1..5).times do
    Review.create(
    body: Faker::Hipster.sentence(5),
    user: users.sample,
    idea: i
    )
  end
end

reviews = Review.all
puts "#{reviews.count} reviews created."
