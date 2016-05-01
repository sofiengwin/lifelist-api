FactoryGirl.define do
  factory :bucketlist do
    name { Faker::Book.title }
    user factory: :user
  end
end
