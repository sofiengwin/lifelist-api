require "rails_helper"

describe "User Logout", type: :request do
  before(:all) do
    password = Faker::Internet.password
    @user = {
      email: Faker::Internet.email,
      password: password,
      password_confirmation: password
    }
    @signed_user = create(:user, @user)
  end

  context "valid logout request" do
    before do
      get("/api/v1/auth/logout",
        {},
        {
          "Accept" => "application/json",
          "Authorization" => login(@signed_user)
        }
      )
    end
    it "should return a status code" do
      expect(response.status).to eq 200
    end

    it "should return json data" do
      expect(response.content_type).to eq Mime::JSON
    end

    it "should return success message" do
      expect(json(response.body)[:success]).to eq "You are now logged out"
    end

    it "should update user status to false" do
      expect(@signed_user.reload.status).to eq false
    end
  end

  context "invalid logout request" do
    before do
      get("/api/v1/auth/logout",
        "Accept" => "application/json"
      )
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
end
