require "rails_helper"

describe "User Creation", type: :request do
  context "creating a user with valid data" do
    let(:new_user) do
      {
        name: Faker::Name.name,
        email: Faker::Internet.email,
        password: "password",
        password_confirmation: "password"
      }
    end

    before do
      post(
        "/api/v1/users",
        { user: new_user }.to_json,
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
      expect(json(response.body)[:message]).to eq "Account created"
    end
  end

  context "creating a user with invalid data" do
    let(:invalid_user) do
      {
        name: nil,
        email: nil,
        password: "pass",
        password_confirmation: "pass"
      }
    end

    before do
      post(
        "/api/v1/users",
        { user: invalid_user }.to_json,
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
      expect(result[:errors][:name]).to include "can't be blank"
      expect(result[:errors][:email]).to include "can't be blank"
      expect(result[:errors][:password]).to include(
        "is too short (minimum is 6 characters)"
      )
    end
  end
end
