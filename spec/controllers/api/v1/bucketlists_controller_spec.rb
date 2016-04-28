require "rails_helper"
require "support/index_action_shared_examples"

RSpec.describe Api::V1::BucketlistsController, type: :request do
  before(:all) do
    @bucketlist_one = Bucketlist.create!(name: "Books")
    Bucketlist.create!(name: "Games")
  end

  describe "GET index" do
    it_behaves_like "valid get request", "/api/v1/bucketlists"
  end

  describe "GET show" do
    before do
      get "/api/v1/bucketlists/#{@bucketlist_one.id}"
    end

    it "should return a status code of 200" do
      expect(response.status).to eq 200
    end

    it "should return json data" do
      expect(Mime::JSON).to eq response.content_type
    end

    it "should return the bucketlist item" do
      expect(json(response.body)[:name]).to eq "Books"
    end
  end

  describe "POST create" do
    context "creating a bucketlist with valid data" do
      before do
        post "/api/v1/bucketlists", { bucketlist: { name: "Movies" }}.to_json,
        { "Accept" => "application/json", "Content-Type" => "application/json"}
      end

      it "should return a status code of 200" do
        expect(response.status).to eq 201
      end

      it "should return the correct location data" do
        id = json(response.body)[:id]
        expect(response.location).to eq api_v1_bucketlist_url(id)
      end

      it "should return the correct content_type" do
        expect(response.content_type).to eq Mime::JSON
      end

      it "it should increase bucketlists count" do
        expect do
          Bucketlist.create(name: "Coding")
        end.to change(Bucketlist, :count).by(1)
      end
    end
  end

  context "creating a bucketlist with invalid data" do
    before do
      post "/api/v1/bucketlists", { bucketlist: { name: nil }}.to_json,
      { "Accept" => "application/json", "Content-Type" => "application/json"}
    end

    it "should return a status code of 422" do
      expect(response.status).to eq 422
    end

    it "it return the error messages" do
      expect(json(response.body)).to include "Name can't be blank"
    end
  end

end
