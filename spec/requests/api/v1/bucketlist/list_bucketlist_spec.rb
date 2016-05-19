require "rails_helper"

describe "Listing Bucketlist" do
  context "when user is not logged in" do
    before(:all) do
      create_list(:bucketlist, 3)
      get "/api/v1/bucketlists"
    end

    it "returns a status code of 401" do
      expect(response.status).to eq 401
    end

    it "returns json data" do
      expect(response.content_type).to eq Mime::JSON
    end

    it "returns error message" do
      expect(json(response.body)[:error]).to eq "Access denied"
    end
  end

  context "when user is logged in" do
    before(:all) do
      @current_user = create(:user, status: true)
      @bucketlists = create_list(:bucketlist, 5, user_id: @current_user.id)
      valid_get_request("/api/v1/bucketlists", @current_user)
    end

    it "returns a status code of 200" do
      expect(response.status).to eq 200
    end

    it "returns only bucketlists belonging to current user" do
      created_by_ids = json(response.body).map { |hsh| hsh[:created_by] }
      result = created_by_ids.all? { |id| id == @current_user.id }
      expect(result).to eq true
    end
  end

  describe "search" do
    context "when making a valid search query" do
      before(:all) do
        current_user = create(:user, status: true)
        create(:bucketlist, name: "Read Pragmatic", user_id: current_user.id)
        create(:bucketlist, name: "Read style guide", user_id: current_user.id)
        valid_get_request("/api/v1/bucketlists?q=read", current_user)
      end

      it "returns a status code of 200" do
        expect(response.status).to eq 200
      end

      it "returns number of bucketlists with search term" do
        expect(json(response.body).count).to eq 2
      end

      it "return bucketlists with search term" do
        names = json(response.body).map { |hsh| hsh[:name] }
        result = names.all? { |name| name.include? "Read" }
        expect(result).to eq true
      end
    end

    context "when making an invalid search query" do
      before(:all) do
        user = create(:user, status: true)
        valid_get_request("/api/v1/bucketlists?q=invalid", user)
      end

      it "returns a status code of 404" do
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
      @user = create(:user, status: true)
      @bucketlists = create_list(:bucketlist, 20, user_id: @user.id)
    end

    context "when limit is passed in params" do
      before(:all) do
        valid_get_request("/api/v1/bucketlists?page=1&limit=10", @user)
      end

      it "returns only ten records" do
        result = json(response.body)
        expect(result.count).to eq 10
      end

      it "returns the correct bucketlists" do
        result = json(response.body)
        expect(result.first[:name]).to eq @bucketlists[0].name
        expect(result.last[:name]).to eq @bucketlists[9].name
      end
    end

    context "when invalid page number and limit is passed in params" do
      before(:all) do
        valid_get_request("/api/v1/bucketlists?page=10&limit=10", @user)
      end

      it "returns a status code of 404" do
        expect(response.status).to eq 404
      end

      it "returns error message" do
        expect(json(response.body)[:error]).to eq "No bucketlist found"
      end
    end

    context "when valid page number is passed in params" do
      before(:all) do
        valid_get_request("/api/v1/bucketlists?page=2&limit=2", @user)
      end

      it "returns only two bucketlists" do
        expect(json(response.body).count).to eq 2
      end

      it "returns the correct bucketlists" do
        result = json(response.body)
        expect(result.first[:name]).to eq @bucketlists[2].name
        expect(result.last[:name]).to eq @bucketlists[3].name
      end
    end
  end
end
