require "rails_helper"

describe "User Creation", type: :request do
  context "when creating a user with valid data" do
    before(:all) do
      post(
        "/api/v1/users",
        attributes_for(:user).to_json,
        "Accept" => "application/json",
        "Content-Type" => "application/json"
      )
    end

    it "returns a status code of 201" do
      expect(response.status).to eq 201
    end

    it "returns json data" do
      expect(Mime::JSON).to eq response.content_type
    end

    it "returns success message" do
      expect(json(response.body)[:message]).to eq language.account_created
    end
  end

  context "when creating a user with invalid data" do
    before(:all) do
      post(
        "/api/v1/users",
        attributes_for(:user, name: nil, email: nil).to_json,
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

    it "returns activer model validation errors" do
      result = json(response.body)
      expect(result[:errors][:name]).to include language.blank
      expect(result[:errors][:email]).to include language.blank
    end
  end
end
