FactoryGirl.define do
  factory :item do
    name { Faker::Internet.name }
    done false
    bucketlist
  end
end
