10.times do |n|
  name = Faker::Games::Pokemon.name
  email = Faker::Internet.email
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               )
end

User.create!(name:  "管理者",
             email: "admin@example.jp",
             password:  "11111111",
             password_confirmation: "11111111",
             admin: true)

10.times do |n|
  label_name = Faker::Food.fruits
  Label.create!( label_name: label_name )
end

10.times do |n|
  name = Faker::Movie.title
  detail = Faker::Movie.quote
  Task.create!(name: name,
               detail: detail,
               )
end
