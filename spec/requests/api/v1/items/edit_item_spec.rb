require "rails_helper"

describe "Editing Item", type: :request do

  context "editing an item with valid data" do
    before(:all) do
      item = create(:item)
      put(
        "/api/v1/bucketlists/#{item.bucketlist.id}/items/#{item.id}",
        { item: { name: "New name", done: true } }.to_json,
        "Accept" => "application/json",
        "Content-Type" => "application/json"
      )
    end

    it "should return a status code of 200" do
      expect(response.status).to eq 200
    end

    it "should return json data" do
      expect(Mime::JSON).to eq response.content_type
    end

    it "should return updated item" do
      expect(json(response.body)[:name]).to eq "New name"
      expect(json(response.body)[:done]).to eq true
    end
  end

  context "editing an item with invalid data" do
    before(:all) do
      item = create(:item)
      put(
        "/api/v1/bucketlists/#{item.bucketlist.id}/items/#{item.id}",
        { item: { name: nil, done: true } }.to_json,
        "Accept" => "application/json",
        "Content-Type" => "application/json"
      )
    end

    it "should return a status code of 422" do
      expect(response.status).to eq 422
    end

    it "should return an error message" do
      expect(json(response.body)[:error]).to eq "Unable to edit item"
    end
  end
end
