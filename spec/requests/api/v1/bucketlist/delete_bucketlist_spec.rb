require "rails_helper"

describe "Deleting Bucketlist" do
  let(:user) { create(:user) }
  it "should return a status code of 204" do
    bucketlist = create(:bucketlist, user_id: user.id)
    delete_request("/api/v1/bucketlists/#{bucketlist.id}", user)
    expect(response.status).to eq 200
  end

  it "should success message" do
    bucketlist = create(:bucketlist, user_id: user.id)
    delete_request("/api/v1/bucketlists/#{bucketlist.id}", user)
    expect(json(response.body)[:notice]).to eq "bucketlist deleted"
  end

  it "it should reduce bucketlist count by one" do
    bucketlist = create(:bucketlist, user_id: user.id)
    expect do
      delete_request("/api/v1/bucketlists/#{bucketlist.id}", user)
    end.to change(Bucketlist, :count).by(-1)
  end
end
