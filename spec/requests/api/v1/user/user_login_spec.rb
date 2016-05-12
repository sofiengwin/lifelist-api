require "rails_helper"

describe "User Login" do
  before(:all) do
    password = Faker::Internet.password
    @user = {
      email: Faker::Internet.email,
      password: password,
      password_confirmation: password
    }
    @signed_user = create(:user, @user)
  end

  context "when making a login request with valid details" do
    before(:all) do
      post(
        "/api/v1/auth/login",
        { email: @user[:email], password: @user[:password] }.to_json,
        "Accept" => "application/json",
        "Content-Type" => "application/json"
      )
    end

    it "returns a status code of 200" do
      expect(response.status).to eq 200
    end

    it "returns json data" do
      expect(response.content_type).to eq Mime::JSON
    end

    it "returns success message" do
      expect(json(response.body)[:success]).to eq "Logged in successfully"
    end

    it "returns an active status" do
      expect(@signed_user.reload.status).to eq true
    end
  end

  context "when making a login request with invalid details" do
    before(:all) do
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

    it "returns a status code of 422" do
      expect(response.status).to eq 422
    end

    it "returns json data" do
      expect(response.content_type).to eq Mime::JSON
    end

    it "returns error message" do
      expect(json(response.body)[:error]).to eq "Unable to login"
    end
  end
end
