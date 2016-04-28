RSpec.shared_examples "valid get request" do |route|
  before do
    get route
  end

  it "should return a status code of 200" do
    expect(response.status).to eq 200
  end

  it "should return json data" do
    expect(response.content_type).to eq Mime::JSON
  end

  it "it should return all bucketlists" do
    bucketlists = json(response.body)
    expect(bucketlists[0][:name]).to eq("Books")
    expect(bucketlists[1][:name]).to eq("Games")
  end
end
