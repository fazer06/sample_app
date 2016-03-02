User.create!( username:  "fazer",
              email: 	 "admin@example.com",
              password:              "password",
              password_confirmation: "password",
              admin: true )

99.times do |n|
  username  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!( username: username,
                email:    email,
                password:              password,
                password_confirmation: password)
end