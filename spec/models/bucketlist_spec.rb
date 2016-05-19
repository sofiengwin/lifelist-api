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

  describe "#paginate" do
    before(:all) do
      Bucketlist.destroy_all
      @bucketlists = create_list(:bucketlist, 50)
    end

    context "valid paginate request" do
      let(:paginate) { Bucketlist.paginate(page: 1, limit: 20) }
      it "return the first 20 bucketlists" do
        expect(paginate.count).to eq 20
      end

      it "return bucketlists in the second page" do
        expect(paginate.first.name).to eq @bucketlists[0].name
        expect(paginate.last.name).to eq @bucketlists[19].name
      end
    end

    context "default pagination" do
      let(:paginate) { Bucketlist.paginate }
      it "return 20 bucketlists" do
        expect(paginate.count).to eq 20
      end

      it "returns bucketlists in the first page" do
        expect(paginate.first.name).to eq @bucketlists[0].name
        expect(paginate.last.name).to eq @bucketlists[19].name
      end
    end
  end

  describe "search" do
    before(:all) do
      3.times { |n| create(:bucketlist, name: "Buy book #{n}") }
    end
    context "when searching with lower case letters" do
      it "should return three bucketlists" do
        expect(Bucketlist.search("book").count).to eq 3
      end
    end

    context "when searching with upper case letters" do
      it "should return three bucketlists" do
        expect(Bucketlist.search("BOOK").count).to eq 3
      end
    end
  end
end
