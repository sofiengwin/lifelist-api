require "rails_helper"
require "support/index_action_shared_examples"

RSpec.describe Api::V1::BucketlistsController, type: :request do
  before(:all) do
    Bucketlist.create!(name: "Books")
    Bucketlist.create!(name: "Games")
  end

  describe "GET index" do
    it_behaves_like "valid get request", "/api/v1/bucketlists"
  end

  describe "GET show" do
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

  describe "POST create" do
    context "creating a bucketlist with valid data" do
      before do
        post(
          "/api/v1/bucketlists",
          { bucketlist: { name: "Movies" } }.to_json,
          { "Accept" => "application/json","Content-Type" => "application/json"}
        )
      end

      it "should return a status code of 200" do
        expect(response.status).to eq 201
      end

      it "should return the correct location data" do
        bucketlist_id = json(response.body)[:id]
        expect(response.location).to eq api_v1_bucketlist_url(bucketlist_id)
      end

      it "should return the correct content_type" do
        expect(Mime::JSON).to eq response.content_type
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
      post("/api/v1/bucketlists",
      { bucketlist: { name: nil } }.to_json,
      { "Accept" => "application/json", "Content-Type" => "application/json"})
    end

    it "should return a status code of 422" do
      expect(response.status).to eq 422
    end

    it "it return the error messages" do
      expect(json(response.body)).to include "Name can't be blank"
    end
  end

  describe "PUT update" do
      let(:bucketlist) { create(:bucketlist) }

    context "updating a bucketlist with valid data" do
      before do
        put "/api/v1/bucketlists/#{bucketlist.id}", { bucketlist: { name: "New name"}}.to_json,
        {"Accept" => "application/json", "Content-Type" => "application/json"}
      end

      it "should return a status code of 200" do
        expect(response.status).to eq 200
      end

      it "should return json data" do
        expect(Mime::JSON).to eq response.content_type
      end

      it "should return the updated buckelist" do
        expect(json(response.body)[:name]).to eq "New name"
      end
    end

    context "updating a buckelist with invalid data" do
      before do
        put "/api/v1/bucketlists/#{bucketlist.id}", { bucketlist: { name: nil }}.to_json,
        {"Accept" => "application/json", "Content-Type" => "application/json"}
      end

      it "should return a status code of 422" do
        expect(response.status).to eq 422
      end

      it "should return the full error messages" do
        expect(json(response.body)).to include "Name can't be blank"
      end
    end
  end

  describe "DELETE destroy" do
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
end
