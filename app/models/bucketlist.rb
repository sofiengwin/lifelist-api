class Bucketlist < ActiveRecord::Base
  belongs_to :user
  has_many :items

  validates :name, presence: true, uniqueness: true
end
