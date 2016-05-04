require "rails_helper"

RSpec.describe Bucketlist, type: :model do
  describe "bucketlist validations" do
    it { should validate_presence_of :name }
  end

  describe "bucketlist associations" do
    it { should belong_to :user }
    it { should have_many :items }
  end
end
