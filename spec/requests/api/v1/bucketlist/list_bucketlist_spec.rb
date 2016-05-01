require "rails_helper"

describe "Listing Bucketlist" do
  context "when user is not logged in" do
    before(:all) do
      create_list(:bucketlist, 3)
      get "/api/v1/bucketlists"
    end

    it "should return a status code of 200" do
      expect(response.status).to eq 401
    end

    it "should return json data" do
      expect(response.content_type).to eq Mime::JSON
    end

    it "should return error message" do
      expect(json(response.body)[:error]).to eq "Access denied"
    end
  end

  context "when user is logged in" do
    before(:each) do
      @current_user = create(:user)
      @bucketlists = create_list(:bucketlist, 5, user_id: @current_user.id)
      get(
        "/api/v1/bucketlists",
        {},
        "Authorization" => login(@current_user)
      )
    end

    it "should return a status code of 200" do
      expect(response.status).to eq 200
    end

    it "should return only bucketlists belonging to current user" do
      created_by_ids = json(response.body).map { |hsh| hsh[:created_by] }
      result = created_by_ids.all? { |id| id == @current_user.id }
      expect(result).to eq true
    end

    it "it should return all bucketlists belonging to current user" do
      result = json(response.body)
      expect(result[0][:name]).to eq @bucketlists[0].name
      expect(result[1][:name]).to eq @bucketlists[1].name
      expect(result[2][:name]).to eq @bucketlists[2].name
    end
  end
end
