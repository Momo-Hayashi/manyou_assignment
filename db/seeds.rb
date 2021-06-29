# 50.times do |n|
#   name = Faker::Games::Pokemon.name
#   email = Faker::Internet.email
#   password = "password"
#   User.create!(name: name,
#                email: email,
#                password: password,
#                )

# User.create!(name:  "管理者",
#              email: "admin@example.jp",
#              password:  "11111111",
#              password_confirmation: "11111111",
#              admin: true)

5.times do |n|
  Label.create!(label_name: '仕事')
end
