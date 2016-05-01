FactoryGirl.define do
  factory :bucketlist do
    name { Faker::Lorem.characters(8) }
    user
  end
end
