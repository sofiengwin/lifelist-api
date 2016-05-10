require "rails_helper"

describe "Creating Bucketlist" do
  context "creating a bucketlist with valid data" do
    before(:all) do
      user = create(:user, status: true)
      post(
        "/api/v1/bucketlists",
        { bucketlist: { name: "Movies" } }.to_json,
        "Content-Type" => "application/json",
        "Authorization" => login(user)
      )
    end

    it "returns a status code of 201" do
      expect(response.status).to eq 201
    end

    it "returns the correct content_type" do
      expect(Mime::JSON).to eq response.content_type
    end

    it "returns the created bucketlist" do
      expect(json(response.body)[:name]).to eq "Movies"
    end
  end

  context "creating a bucketlist with invalid data" do
    before(:all) do
      user = create(:user, status: true)
      post(
        "/api/v1/bucketlists",
        { bucketlist: { name: nil } }.to_json,
        "Accept" => "application/json",
        "Content-Type" => "application/json",
        "Authorization" => login(user)
      )
    end

    it "returns a status code of 422" do
      expect(response.status).to eq 422
    end

    it "returns the error messages" do
      expect(json(response.body)[:errors][:name]).to include(
        "can't be blank"
      )
    end
  end
end
