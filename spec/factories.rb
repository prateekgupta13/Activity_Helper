FactoryGirl.define do
  factory :user do
    sequence(:username){ |n| "Username #{n}" }
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar123"
    password_confirmation "foobar123"
  end

  factory :activity do
    category "sports"
    name "Cricket"
    description "desc"
    user
  end

  factory :comment do
    content "wonderful"
    user
    activity
  end

  factory :friendship do
    status  default: false
    user
    friend_id 2
  end

  factory :message do
    message "Hello"
    friendship
  end
end