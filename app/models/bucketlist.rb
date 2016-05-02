class Bucketlist < ActiveRecord::Base
  belongs_to :user
  has_many :items

  validates :name, presence: true, uniqueness: true

  scope :search, lambda { |search_term = nil|
    where("lower(name) LIKE ?", "%#{search_term}%") unless search_term.nil?
  }

  scope :paginate, lambda { |params = {}|
    set_limit = params[:limit] || 5
    page = params[:page] || 0
    set_limit = set_limit.to_i > 5 ? 5 : set_limit.to_i
    set_offset = (page.to_i * set_limit) - 1
    limit(set_limit).offset(set_offset)
  }
end
