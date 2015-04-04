# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Groups
Group.create!(name: "Test group 1")

Group.create!(name: "Test group 2")

# Admin user
User.create!(email: "admin@test.com",
             password: "password",
             password_confirmation: "password").add_role(:admin)

# Group admin users
Group.first.users.create!(email: "admin1@test.com",
                          password: "password",
                          password_confirmation: "password").add_role(:group_admin)

Group.second.users.create!(email: "admin2@test.com",
                           password: "password",
                           password_confirmation: "password").add_role(:group_admin)

# Users
Group.all.each do |group|
  10.times do |n|
    email = "user#{group.id}#{n+1}@test.com"
    password = "password"
    group.users.create!(email: email,
                        password: password,
                        password_confirmation: password)
  end
end

# Microposts
users = User.all
5.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.microposts.create!(content: content) }
end