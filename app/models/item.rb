class Item < ActiveRecord::Base
  belongs_to :bucketlist

  validates :name, presence: true
end
