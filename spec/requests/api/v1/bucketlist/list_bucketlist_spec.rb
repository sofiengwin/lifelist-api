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
    before(:all) do
      @current_user = create(:user)
      @bucketlists = create_list(:bucketlist, 5, user_id: @current_user.id)
      valid_get_request("/api/v1/bucketlists", @current_user)
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

  describe "search" do
    before(:all) do
    end

    context "valid search query" do
      before(:all) do
        current_user = create(:user)
        create(:bucketlist, name: "Read Pragmatic Programmer", user_id: current_user.id)
        create(:bucketlist, name: "Read Seven Languages In Seven Days", user_id: current_user.id)
        valid_get_request("/api/v1/bucketlists?search=read", current_user)
      end

      it "should return a status code of 200" do
        expect(response.status).to eq 200
      end

      it "should return number bucketlists with search term" do
        expect(json(response.body).count).to eq 2
      end

      it "should return bucketlists with search term" do
        names = json(response.body).map { |hsh| hsh[:name] }
        result = names.all? { |name| name.include? "Read" }
        expect(result).to eq true
      end
    end

    context "empty search result" do
      before(:all) do
        user = create(:user)
        valid_get_request("/api/v1/bucketlists?search=invalid", user)
      end

      it "should return a status code of 404" do
        expect(response.status).to eq 404
      end

      it "returns error message" do
        expect(json(response.body)[:error]).to eq "No bucketlist found"
      end
    end
  end
end
