require "rails_helper"

describe "Deleting Item" do
  context "when making a valid delete request" do
    before(:all) do
      item = create(:item)
      delete_request(
        "/api/v1/bucketlists/#{item.bucketlist.id}/items/#{item.id}",
        item.bucketlist.user
      )
    end

    it "returns a status code of 204" do
      expect(response.status).to eq 200
    end

    it "returns a success message" do
      expect(json(response.body)[:success]).to eq "Item deleted successfully"
    end
  end

  it "should decrease items count" do
    item = create(:item)
    expect do
      delete_request(
        "/api/v1/bucketlists/#{item.bucketlist.id}/items/#{item.id}",
        item.bucketlist.user
      )
    end.to change(Item, :count).by(-1)
  end
end
