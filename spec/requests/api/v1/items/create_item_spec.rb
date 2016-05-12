require "rails_helper"

describe "Item Create Action", type: :request do
  context "when creating an item with valid data" do
    before(:all) do
      bucketlist = create(:bucketlist)
      post(
        "/api/v1/bucketlists/#{bucketlist.id}/items",
        { name: "New item", done: false }.to_json,
        "Accept" => "application/json",
        "Content-Type" => "application/json",
        "Authorization" => login(bucketlist.user)
      )
    end

    it "returns a status code of 201" do
      expect(response.status).to eq 201
    end

    it "returns json data" do
      expect(Mime::JSON).to eq response.content_type
    end

    it "returns the created item" do
      item = json(response.body)
      expect(item[:name]).to eq "New item"
      expect(item[:done]).to eq false
    end
  end

  context "when creating an item with invalid data" do
    before(:all) do
      bucketlist = create(:bucketlist)
      post(
        "/api/v1/bucketlists/#{bucketlist.id}/items",
        { name: nil, done: false }.to_json,
        "Accept" => "application/json",
        "Content-Type" => "application/json",
        "Authorization" => login(bucketlist.user)
      )
    end

    it "returns a status code of 422" do
      expect(response.status).to eq 422
    end

    it "return error messages" do
      expect(json(response.body)[:errors][:name]).to include("can't be blank")
    end
  end

  context "when creating item without token" do
    before(:all) do
      bucketlist = create(:bucketlist)
      post(
        "/api/v1/bucketlists/#{bucketlist.id}/items",
        { name: "No Token" }.to_json,
        "Accept" => "application/json",
        "Content-Type" => "application/json"
      )
    end

    it "returns a status code of 401" do
      expect(response.status).to eq 401
    end

    it "returns an error message" do
      expect(json(response.body)[:error]).to eq "Access denied"
    end
  end
end
