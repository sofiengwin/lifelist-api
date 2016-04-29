require "rails_helper"

describe "Deleting Item" do
  let(:item) { create(:item) }

  before(:each) do
    delete("/api/v1/bucketlists/#{item.bucketlist.id}/items/#{item.id}",
           {},
           "Accept" => "application/json"
          )
  end

  it "should return a status code of 204" do
    expect(response.status).to eq 200
  end

  it "should return a success message" do
    expect(json(response.body)[:success]).to eq "Item deleted successfully"
  end

  it "should decrease items count" do
    item = create(:item, name: "to be deleted")
    expect do
      delete "/api/v1/bucketlists/#{item.bucketlist.id}/items/#{item.id}"
    end.to change(Item, :count).by(-1)
  end
end
