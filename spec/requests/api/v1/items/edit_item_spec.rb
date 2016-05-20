require "rails_helper"

describe "Editing Item", type: :request do
  context "when editing an item with valid data" do
    before(:all) do
      item = create(:item)
      put(
        "/api/v1/bucketlists/#{item.bucketlist.id}/items/#{item.id}",
        { name: "New name", done: true }.to_json,
        "Accept" => "application/json",
        "Content-Type" => "application/json",
        "Authorization" => login(item.bucketlist.user)
      )
    end

    it "returns a status code of 200" do
      expect(response.status).to eq 200
    end

    it "returns json data" do
      expect(Mime::JSON).to eq response.content_type
    end

    it "returns updated item" do
      expect(json(response.body)[:name]).to eq "New name"
      expect(json(response.body)[:done]).to eq true
    end
  end

  context "when editing an item with invalid data" do
    before(:all) do
      item = create(:item)
      put(
        "/api/v1/bucketlists/#{item.bucketlist.id}/items/#{item.id}",
        { name: nil, done: true }.to_json,
        "Accept" => "application/json",
        "Content-Type" => "application/json",
        "Authorization" => login(item.bucketlist.user)
      )
    end

    it "returns a status code of 422" do
      expect(response.status).to eq 422
    end

    it "returns an error message" do
      expect(json(response.body)[:errors][:name]).to include(language.blank)
    end
  end
end
