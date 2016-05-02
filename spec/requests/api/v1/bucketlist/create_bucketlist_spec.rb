require "rails_helper"

describe "Creating Bucketlist" do
  let(:user) { create(:user) }

  after(:all) do
    Bucketlist.destroy_all
  end

  context "creating a bucketlist with valid data" do
    before(:all) do
      user = create(:user)
      post(
        "/api/v1/bucketlists",
        { bucketlist: { name: "Movies", user_id: user.id } }.to_json,
        "Accept" => "application/json", "Content-Type" => "application/json"
      )
    end

    it "should return a status code of 201" do
      expect(response.status).to eq 201
    end

    it "should return the correct location data" do
      bucketlist_id = json(response.body)[:id]
      expect(response.location).to eq api_v1_bucketlist_url(bucketlist_id)
    end

    it "should return the correct content_type" do
      expect(Mime::JSON).to eq response.content_type
    end

    it "should increase bucketlists count" do
      expect do
        Bucketlist.create(name: "Coding")
      end.to change(Bucketlist, :count).by(1)
    end
  end

  context "creating a bucketlist with invalid data" do
    before do
      post("/api/v1/bucketlists",
           { bucketlist: { name: nil } }.to_json,
           "Accept" => "application/json", "Content-Type" => "application/json")
    end

    it "should return a status code of 422" do
      expect(response.status).to eq 422
    end

    it "should return the error messages" do
      expect(json(response.body)[:errors][:name]).to include(
        "can't be blank"
      )
    end
  end
end
