# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(
  name: 'admin',
  email: 'admin@example.com',
  admin: true,
  password: 'password',
  id: 100
)

100.times do |i|
  Task.create(name: "コメダ珈琲 #{i}", user_id: 100)
end
