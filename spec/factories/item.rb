FactoryGirl.define do
  factory :item do
    name "Item Name"
    done false
    bucketlist factory: :bucketlist
  end
end
