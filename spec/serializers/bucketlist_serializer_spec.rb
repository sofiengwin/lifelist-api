require "rails_helper"

describe BucketlistSerializer, type: :serializer do
  let(:bucketlist) { create(:bucketlist) }

  let(:items) { create_list(:item, 5, bucketlist_id: bucketlist.id) }

  let(:serializer) { BucketlistSerializer.new(bucketlist) }

  subject { json(serializer.to_json) }

  it "returns the bucketlist id" do
    expect(subject[:id]).to eq bucketlist.id
  end

  it "returns the bucketlist name" do
    expect(subject[:name]).to eq bucketlist.name
  end

  it "returns an array of items belonging to the bucketlist" do
    expect(subject[:items]).to be_an Array
  end

  it "returns the date the bucketlist was created" do
    expect(subject[:date_created]).to eq bucketlist.created_at.strftime(
      "%Y-%m-%d %H:%M:%S"
    )
  end

  it "returns the date the bucketlist was last modified" do
    expect(subject[:date_modified]).to eq bucketlist.updated_at.strftime(
      "%Y-%m-%d %H:%M:%S"
    )
  end

  it "returns the user id of the bucketlist owner" do
    expect(subject[:created_by]).to eq bucketlist.user.id
  end
end
