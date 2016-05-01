FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| Faker::Name.name + n.to_s}
    email { Faker::Internet.email }
    password "password"
    password_confirmation "password"
  end
end
