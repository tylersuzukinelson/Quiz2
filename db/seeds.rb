Idea.destroy_all
User.destroy_all

admin = User.create(first_name:'John', last_name:'Lam', email:'admin@admin.com', password:'123')

10.times do
  User.create(
  first_name:Faker::Name.first_name,
  last_name:Faker::Name.last_name,
  email:Faker::Internet.email,
  password: '123' )
end
puts '11 Users created.'

users = User.all

20.times do
  Idea.create(
  title: Faker::Hipster.sentence(3),
  description: Faker::Hipster.paragraph(3),
  user: users.sample,
  member_count: rand(1..25),
  like_count: rand(1..200)

  )
end
puts '20 Ideas created.'
