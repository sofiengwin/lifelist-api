require "rails_helper"

describe AuthToken do
  subject { AuthToken.new }
  let(:user) { create(:user) }
  let(:token) { subject.encode(user.id, 3) }

  describe "#encode" do
    it "returns encoded token" do
      expect(token).to be_truthy
    end
  end

  describe "#decode" do
    context "expired token" do
      sleep 5
      it "returns nil" do
        expect(subject.decode(token)).to eq nil
      end

      context "invalid token" do
        it "returns nil" do
          expect(subject.decode("hheejs.jjsjsjksjkksks.jk")).to eq nil
        end
      end
    end
  end
end
