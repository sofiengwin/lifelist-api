require "rails_helper"

describe "Listing Bucketlist" do
  context "when user is not logged in" do
    before(:all) do
      create_list(:bucketlist, 3)
      get "/api/v1/bucketlists"
    end

    it "should return a status code of 401" do
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
      @current_user = create(:user, status: true)
      @bucketlists = create_list(:bucketlist, 5, user_id: @current_user.id)
      token = AuthToken.new.encode(@current_user.id)
      valid_get_request("/api/v1/bucketlists", token)
    end

    it "should return a status code of 200" do
      expect(response.status).to eq 200
    end

    it "should return only bucketlists belonging to current user" do
      created_by_ids = json(response.body).map { |hsh| hsh[:created_by] }
      result = created_by_ids.all? { |id| id == @current_user.id }
      expect(result).to eq true
    end
  end

  describe "search" do
    context "valid search query" do
      before(:all) do
        current_user = create(:user, status: true)
        token = AuthToken.new.encode(current_user.id)
        create(:bucketlist, name: "Read Pragmatic", user_id: current_user.id)
        create(:bucketlist, name: "Read style guide", user_id: current_user.id)
        valid_get_request("/api/v1/bucketlists?q=read", token)
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

    context "invalid search query" do
      before(:all) do
        user = create(:user, status: true)
        token = AuthToken.new.encode(user.id)
        valid_get_request("/api/v1/bucketlists?q=invalid", token)
      end

      it "should return a status code of 404" do
        expect(response.status).to eq 404
      end

      it "returns error message" do
        expect(json(response.body)[:error]).to eq "No bucketlist found"
      end
    end
  end

  describe "pagination" do
    before(:all) do
      Bucketlist.destroy_all
      user = create(:user, status: true)
      @token = AuthToken.new.encode(user.id)
      @bucketlists = create_list(:bucketlist, 20, user: user)
    end

    context "limit is passed in params" do
      before(:all) do
        valid_get_request("/api/v1/bucketlists?page=1&limit=10", @token)
      end

      it "returns only twenty records" do
        result = json(response.body)
        expect(result.count).to eq 10
      end

      it "returns the correct bucketlists" do
        result = json(response.body)
        expect(result.first[:name]).to eq @bucketlists[9].name
        expect(result.last[:name]).to eq @bucketlists[18].name
      end
    end

    context "invalid page number and limit" do
      before(:all) do
        valid_get_request("/api/v1/bucketlists?page=10&limit=10", @token)
      end

      it "returns a status code of 404" do
        expect(response.status).to eq 404
      end

      it "should return error message" do
        expect(json(response.body)[:error]).to eq "No bucketlist found"
      end
    end

    context "valid page number" do
      before(:all) do
        valid_get_request("/api/v1/bucketlists?page=2&limit=2", @token)
      end

      it "returns only two bucketlists" do
        expect(json(response.body).count).to eq 2
      end

      it "returns the correct bucketlists" do
        result = json(response.body)
        expect(result.first[:name]).to eq @bucketlists[3].name
        expect(result.last[:name]).to eq @bucketlists[4].name
      end
    end
  end
end
