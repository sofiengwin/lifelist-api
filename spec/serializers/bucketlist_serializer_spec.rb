require "rails_helper"

describe BucketlistSerializer, type: :serializer do
  let(:bucketlist) { create(:bucketlist) }

  let(:items) { create_list(:item, 5, bucketlist_id: bucketlist.id ) }

  let(:serializer) { BucketlistSerializer.new(bucketlist) }

  subject { json(serializer.to_json) }

  it "should return the bucketlist id" do
    expect(subject[:id]).to eq bucketlist.id
  end

  it "should return the bucketlist name" do
    expect(subject[:name]).to eq bucketlist.name
  end

  it "should return an array of items belonging to the bucketlist" do
    expect(subject[:items]).to kind_of Array
  end

  it "should return the date the bucketlist was created" do
    expect(subject[:date_created]).to eq bucketlist.created_at.strftime(
      "%Y-%m-%d %H:%M:%S"
    )
  end

  it "should return the date the bucketlist was last modified" do
    expect(subject[:date_modified]).to eq bucketlist.updated_at.strftime(
      "%Y-%m-%d %H:%M:%S"
    )
  end

  it "should return the user id of the bucketlist owner" do
    expect(subject[:created_by]).to eq bucketlist.user.id
  end
end
