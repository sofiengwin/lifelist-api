class User < ActiveRecord::Base
  before_create :login_user

  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }

  has_many :bucketlists, dependent: :destroy

  has_secure_password

  def login_user
    self.status = true
  end
end
