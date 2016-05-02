class Bucketlist < ActiveRecord::Base
  belongs_to :user
  has_many :items

  validates :name, presence: true, uniqueness: true

  scope :search, lambda { |search_term|
    where("lower(name) LIKE ?", "%#{search_term}%") unless search_term.nil?
  }
end
