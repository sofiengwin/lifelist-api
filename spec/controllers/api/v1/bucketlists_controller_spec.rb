require "rails_helper"

RSpec.describe Api::V1::BucketlistsController, type: :controller do
  before(:all) do
    @current_user = create(:user, status: true)
    @bucketlists = create_list(:bucketlist, 3, user_id: @current_user.id)
  end

  before(:each) do
    allow_any_instance_of(ApplicationController).
      to receive(:current_user).and_return(@current_user)
  end

  describe "GET index" do
    before(:each) do
      get :index
    end

    context "when making valid get request" do
      it "returns a status code of 200" do
        expect(response.status).to eq 200
      end

      it "return bucketlists belonging to current user" do
        created_by_ids = json(response.body).map { |hsh| hsh[:created_by] }
        result = created_by_ids.all? { |id| id == @current_user.id }
        expect(result).to eq true
      end
    end
  end

  describe "GET show" do
    context "when bucketlist exists" do
      before(:each) do
        get :show, id: @bucketlists[0]
      end

      it "returns a status code of 200" do
        expect(response.status).to eq 200
      end

      it "returns the bucketlist" do
        expect(json(response.body)[:name]).to eq @bucketlists[0].name
      end
    end

    context "when bucketlist does not exist" do
      before(:each) do
        get :show, id: 100
      end

      it "returns a status code of 400" do
        expect(response.status).to eq 400
      end

      it "returns an error message" do
        expect(json(response.body)[:error]).to eq "Request cannot be completed"
      end
    end
  end

  describe "POST create" do
    context "when creating bucketlist with valid details" do
      before(:each) do
        post :create, attributes_for(:bucketlist, name: "Coding")
      end

      it "returns a status code of 201" do
        expect(response.status).to eq 201
      end

      it "returns the created bucketlist" do
        expect(json(response.body)[:name]).to eq "Coding"
      end
    end

    context "when creating bucketlist with invalid details" do
      before(:each) do
        post :create, attributes_for(:bucketlist, name: nil)
      end

      it "returns a status code 422" do
        expect(response.status).to eq 422
      end

      it "returns an error message" do
        expect(json(response.body)[:errors][:name]).to include "can't be blank"
      end
    end
  end

  describe "PUT update" do
    context "when updating a valid bucketlist" do
      before(:each) do
        put(
          :update,
          attributes_for(
            :bucketlist,
            name: "Updated bucketlist",
            id: @bucketlists[0]
          )
        )
      end

      it "returns a status code of 200" do
        expect(response.status).to eq 200
      end

      it "returns the updated bucketlist" do
        expect(json(response.body)[:name]).to eq "Updated bucketlist"
      end
    end

    context "when updating an invalid bucketlist" do
      before(:each) do
        put :update, attributes_for(:bucketlist, id: 100)
      end

      it "returns a status code of 400" do
        expect(response.status).to eq 400
      end

      it "returns an error message" do
        expect(json(response.body)[:error]).to eq "Request cannot be completed"
      end
    end
  end

  describe "DELETE destroy" do
    context "when deleting a valid bucketlist" do
      it "should decrease link count by 1" do
        expect do
          delete :destroy, id: @bucketlists[0]
        end.to change(Bucketlist, :count).by(-1)
      end
    end

    context "when deleting an invalid bucketlist" do
      it "should not decrease bucketlist count" do
        expect do
          delete :destroy, id: 100
        end.to change(Bucketlist, :count).by(0)
      end
    end
  end
end
