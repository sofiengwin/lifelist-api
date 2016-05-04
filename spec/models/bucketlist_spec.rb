require "rails_helper"

RSpec.describe Bucketlist, type: :model do
  subject { create(:bucketlist) }

  describe "instance methods" do
    it { is_expected.to respond_to :name }
    it { is_expected.to respond_to :user }
  end
  describe "bucketlist validations" do
    it { should validate_presence_of :name }
  end

  describe "bucketlist associations" do
    it { should belong_to :user }
    it { should have_many :items }
  end
end
