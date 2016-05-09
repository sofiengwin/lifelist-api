require "rails_helper"

describe "User Creation", type: :request do
  context "creating a user with valid data" do
    let(:new_user) {
      {
        name: Faker::Name.name,
        email: Faker::Internet.email,
        password: "password",
        password_confirmation: "password"
      }
    }

    before do
      post(
        "/api/v1/users",
        { user: new_user }.to_json,
        "Accept" => "application/json",
        "Content-Type" => "application/json"
      )
    end

    it "should return a status code of 201" do
      expect(response.status).to eq 201
    end

    it "should return json data" do
      expect(Mime::JSON).to eq response.content_type
    end

    it "should return the newly created user" do
      user = json(response.body)
      expect(user[:name]).to eq new_user[:name]
      expect(user[:email]).to eq new_user[:email]
    end
  end

  context "creating a user with invalid data" do
    let(:invalid_user) {
      {
        name: nil,
        email: nil,
        password: "pass",
        password_confirmation: "pass"
      }
    }

    before do
      post(
        "/api/v1/users",
        { user: invalid_user }.to_json,
        "Accept" => "application/json",
        "Content-Type" => "application/json"
      )
    end

    it "should return a status code of 422" do
      expect(response.status).to eq 422
    end

    it "should return json data" do
      expect(response.content_type).to eq Mime::JSON
    end

    it "should return activer model validation errors" do
      result = json(response.body)
      expect(result[:errors][:name]).to include "can't be blank"
      expect(result[:errors][:email]).to include "can't be blank"
      expect(result[:errors][:password]).to include(
        "is too short (minimum is 6 characters)"
      )
    end
  end
end
