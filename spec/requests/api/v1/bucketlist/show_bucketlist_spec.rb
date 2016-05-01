require "rails_helper"

describe "Show Action" do
  let(:bucketlist) { create(:bucketlist, name: "Coding") }

  before do
    get "/api/v1/bucketlists/#{bucketlist.id}"
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
