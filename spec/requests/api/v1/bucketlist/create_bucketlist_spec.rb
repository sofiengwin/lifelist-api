require "rails_helper"

describe "Creating Bucketlist" do
  context "when creating a bucketlist with valid data" do
    before(:all) do
      user = create(:user)
      post(
        "/api/v1/bucketlists",
        { name: "Movies" },
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

  context "when creating a bucketlist with invalid data" do
    before(:all) do
      user = create(:user)
      post(
        "/api/v1/bucketlists",
        { name: nil }.to_json,
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
        language.blank
      )
    end
  end

  context "when creating bucketlist without token" do
    before(:all) do
      post(
        "/api/v1/bucketlists",
        { name: "No Token" }.to_json,
        "Accept" => "application/json",
        "Content-Type" => "application/json"
      )
    end

    it "returns a status code of 401" do
      expect(response.status).to eq 401
    end

    it "returns an error message" do
      expect(json(response.body)[:error]).to eq language.access_denied
    end
  end
end
