require "rails_helper"

RSpec.describe Item, type: :model do
  subject { create(:item) }

  describe "instance methods" do
    it { is_expected.to respond_to :name }
    it { is_expected.to respond_to :done }
    it { is_expected.to respond_to :bucketlist }
  end

  describe "item validations" do
    it { should validate_presence_of :name }
  end

  describe "item associations" do
    it { should belong_to :bucketlist }
  end
end
