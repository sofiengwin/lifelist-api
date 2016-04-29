require "rails_helper"

describe "User Creation", type: :request do
  context "creating a user with valid data" do
    before do
      post(
        "/api/v1/users",
        {
          user:
          {
            name: Faker::Name.name,
            email: Faker::Internet.email,
            password: "password",
            password_confirmation: "password"
          }
        }.to_json,
        "Accept" => "application/json",
        "Content-Type" => "application/json"
      )
    end
    it { should respond_with 201 }

    it "should return json data" do
      expect(Mime::JSON).to eq response.content_type
    end

    it "should return the location data" do
      expect(response.location).to eq api_v1_users_url(json(response.body)[:id])
    end

    it "should return a success message" do
      message = json(response.body)[:success]
      expect(result).to eq "Account successfully created"
    end
  end

  context "creating a user with invalid data" do
  end
end
