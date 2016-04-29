require "rails_helper"

describe "User Login" do
  before(:all) do
    @user = { email: Faker::Internet.email, password: Faker::Internet.password }
    @signed_user = create(:user, @user)
  end

  context "with valid login details" do
    before do
      post(
        "/api/v1/auth/login",
        { email: @user[:email], password: @user[:password] }.to_json,
        "Accept" => "application/json",
        "Content-Type" => "application/json"
      )
    end

    it "should return a status code of 200" do
      expect(response.status).to eq 200
    end

    it "should return json data" do
      expect(response.content_type).to eq Mime::JSON
    end

    it "should return success message" do
      expect(json(response.body)[:success]).to eq "Logged in successfully"
    end

    it "returns an active status" do
      expect(@signed_user.reload.status).to eq true
    end
  end

  context "with invalid login details" do
    before do
      post(
        "/api/v1/auth/login",
        {
          email: Faker::Internet.email,
          password: Faker::Internet.password
        }.to_json,
        "Accept" => "application/json",
        "Content-Type" => "application/json"
      )
    end

    it "should a status code of 422" do
      expect(response.status).to eq 422
    end

    it "should return json data" do
      expect(response.content_type).to eq Mime::JSON
    end

    it "should return error message" do
      expect(json(response.body)[:error]).to eq "Unable to login"
    end
  end
end
