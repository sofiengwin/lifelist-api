class Bucketlist < ActiveRecord::Base
  belongs_to :user

  has_many :items, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  scope :search, lambda { |search_term = nil|
    where("lower(name) LIKE ?", "%#{search_term}%") unless search_term.nil?
  }

  scope :paginate, lambda { |params = {}|
    limit = params[:limit] || 20
    page = params[:page] || 0
    set_limit = limit.to_i > 100 ? 100 : limit.to_i
    set_offset = page == 0 ? 0 : (page.to_i * set_limit) - 1
    limit(set_limit).offset(set_offset)
  }
end
