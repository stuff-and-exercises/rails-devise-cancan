# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Users
User.create!(email: "admin1@test.com",
             password: "password",
             password_confirmation: "password")

User.create!(email: "admin2@test.com",
             password: "password",
             password_confirmation: "password")

20.times do |n|
  email = "user#{n+1}@test.com"
  password = "password"
  User.create!(email: email,
               password: password,
               password_confirmation: password)
end

# Microposts
users = User.all
5.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.microposts.create!(content: content) }
end