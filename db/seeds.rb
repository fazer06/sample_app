# console commands for heroku reset, migrate, and seed 

# heroku pg:reset DATABASE
# heroku run rake db:migrate
# heroku run rake db:seed

User.create!( username:  "fazer",
              email: 	 "admin@example.com",
              password:              "password",
              password_confirmation: "password",
              admin: true,
              activated: true,
              activated_at: Time.zone.now )

User.create!( username:  "ruth",
              email:   "ruth@example.com",
              password:              "password",
              password_confirmation: "password",
              activated: true,
              activated_at: Time.zone.now )

User.create!( username:  "renee24",
              email:   "renee@example.com",
              password:              "password",
              password_confirmation: "password",
              activated: true,
              activated_at: Time.zone.now )

User.create!( username:  "spyjo",
              email:   "jo@example.com",
              password:              "password",
              password_confirmation: "password",
              activated: true,
              activated_at: Time.zone.now )

#99.times do |n|
#  username  = Faker::Name.name
#  email = "example-#{n+1}@railstutorial.org"
#  password = "password"
#  User.create!( username: username,
#                email:    email,
#                password:              password,
#                password_confirmation: password,
#                activated: true,
#                activated_at: Time.zone.now )
#end

users = User.order(:created_at).take(4)
50.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.microposts.create!(content: content) }
end