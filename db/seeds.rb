User.create!(name:         "anima",
             email:        "anima@example.com",
             password:     "ryusuke",
             image_name:   '1.jpg',
             activated:    true,
             activated_at: Time.zone.now)

             4.times do |n|
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
following = users[2..4]
followers = users[3..4]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

users = User.order(:created_at).take(6)
4.times do
  content = Faker::Lorem.sentence(1)
  detail  = Faker::Lorem.sentence(5)
  users.each { |user| user.posts.create!(content: content, detail: detail) }
end