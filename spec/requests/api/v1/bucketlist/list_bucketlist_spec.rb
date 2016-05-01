require "rails_helper"

describe "Listing Bucketlist" do
  before(:all) do
    @bucketlists = create_list(:bucketlist, 3)
  end

  before do
    get "/api/v1/bucketlists"
  end

  it "should return a status code of 200" do
    expect(response.status).to eq 200
  end

  it "should return json data" do
    expect(response.content_type).to eq Mime::JSON
  end

  it "it should return all bucketlists" do
    result = json(response.body)
    expect(result[0][:name]).to eq @bucketlists[0].name
    expect(result[1][:name]).to eq @bucketlists[1].name
    expect(result[2][:name]).to eq @bucketlists[2].name
  end
end
