require "rails_helper"

RSpec.describe User, type: :model do
  subject { create(:user) }

  describe "Instance Methods" do
    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:email) }
    it { is_expected.to respond_to(:status) }
  end

  describe "user validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_length_of(:password).is_at_least(6) }
  end

  describe "secure password" do
    it { should have_secure_password }
  end

  describe "user associations" do
    it { should have_many(:bucketlists) }
  end
end
