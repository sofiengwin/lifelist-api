FactoryGirl.define do
  factory :bucketlist do
    name { Faker::Book.title }
    user nil
  end
end
