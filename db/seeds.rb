User.create!(name:         "anima",
             email:        "anima@example.com",
             password:     "ryusuke",
             image_name:   '1.jpg',
             activated:    true,
             activated_at: Time.zone.now)

             99.times do |n|
                name       = Faker::Name.name
                email      = "example-#{n+1}@railstutorial.org"
                password   = "password"
                User.create!(name:        name,
                            email:        email,
                            password:     password,
                            image_name:   "default_users.jpg",
                            activated:    true,
                            activated_at: Time.zone.now)
              end

# リレーションシップ
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }