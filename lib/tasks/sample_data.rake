namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
     User.create!(username:"Exampless", name: "Example User",
                         email: "testss@railstutorial.org",
                         password: "foobar123",
                         password_confirmation: "foobar123")
    9.times do |n|
      username= "name-#{n+1}"
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(username:username,
                   name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
    users = User.all(limit: 6)
    35.times do |n|
      name = "name-#{n+1}"
      category = "example-#{n+1}"
      description = Faker::Lorem.sentence(5)
      users.each { |user| user.activities.create!(category: category,name: name,description: description) }
    end
  end
end