require "rails_helper"

describe "Show Action" do
  before(:all) do
    user = create(:user, status: true)
    token = AuthToken.new.encode(user.id)
    bucketlist = create(:bucketlist, name: "Coding", user: user)
    valid_get_request("/api/v1/bucketlists/#{bucketlist.id}", token)
  end

  it "should return a status code of 200" do
    expect(response.status).to eq 200
  end

  it "should return json data" do
    expect(Mime::JSON).to eq response.content_type
  end

  it "should return the bucketlist item" do
    expect(json(response.body)[:name]).to eq "Coding"
  end
end
