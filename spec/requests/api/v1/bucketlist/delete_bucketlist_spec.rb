require "rails_helper"

describe "Deleting Bucketlist" do
  it "should return a status code of 204" do
    bucketlist = create(:bucketlist)
    delete "/api/v1/bucketlists/#{bucketlist.id}"
    expect(response.status).to eq 200
  end

  it "should success message" do
    bucketlist = create(:bucketlist)
    delete "/api/v1/bucketlists/#{bucketlist.id}"
    expect(json(response.body)[:notice]).to eq "bucketlist deleted"
  end

  it "it should reduce bucketlist count by one" do
    bucketlist = create(:bucketlist)
    expect do
      delete "/api/v1/bucketlists/#{bucketlist.id}"
    end.to change(Bucketlist, :count).by(-1)
  end
end
