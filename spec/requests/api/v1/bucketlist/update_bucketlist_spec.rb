require "rails_helper"

describe "Updating bucketlist" do
  let(:bucketlist) { create(:bucketlist) }

  context "updating a bucketlist with valid data" do
    before(:all) do
      user = create(:user)
      bucketlist = create(:bucketlist, user_id: user.id)

      put(
        "/api/v1/bucketlists/#{bucketlist.id}",
        { bucketlist: { name: "New name" } }.to_json,
        "Accept" => "application/json",
        "Content-Type" => "application/json",
        "Authorization" => login(user)
      )
    end

    it "should return a status code of 200" do
      expect(response.status).to eq 200
    end

    it "should return json data" do
      expect(Mime::JSON).to eq response.content_type
    end

    it "should return the updated buckelist" do
      expect(json(response.body)[:name]).to eq "New name"
    end
  end

  context "updating a buckelist with invalid data" do
    before(:all) do
      user = create(:user)
      bucketlist = create(:bucketlist, user_id: user.id)

      put(
        "/api/v1/bucketlists/#{bucketlist.id}",
        { bucketlist: { name: nil } }.to_json,
        "Accept" => "application/json",
        "Content-Type" => "application/json",
        "Authorization" => login(user)
      )
    end

    it "should return a status code of 422" do
      expect(response.status).to eq 422
    end

    it "should return the full error messages" do
      expect(json(response.body)[:errors][:name]).to include(
        "can't be blank"
      )
    end
  end
end
