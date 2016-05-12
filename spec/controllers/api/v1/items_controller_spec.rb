require "rails_helper"

RSpec.describe Api::V1::ItemsController, type: :controller do
  before(:all) do
    @item = create(:item)
    @user = @item.bucketlist.user
  end

  before(:each) do
    allow_any_instance_of(ApplicationController).
      to receive(:current_user).and_return(@user)
  end

  describe "POST create" do
    context "when creating an item with valid details" do
      it "should increase item count by 1" do
        expect do
          post :create, attributes_for(
            :item,
            bucketlist_id: @item.bucketlist.id,
            id: @item.id
          )
        end.to change(Item, :count).by(1)
      end
    end

    context "when creating an item with invalid details" do
      it "should not increase item count" do
        expect do
          post :create, attributes_for(
            :item,
            name: nil,
            bucketlist_id: @item.bucketlist.id
          )
        end.to change(Item, :count).by(0)
      end
    end
  end

  describe "PUT update" do
    context "when updating with valid details" do
      it "returns status code of 200" do
        put :update, attributes_for(
          :item,
          bucketlist_id: @item.bucketlist.id,
          id: @item.id
        )
        expect(response.status).to eq 200
      end
    end

    context "when updating with invalid details" do
      before(:each) do
        put(
          :update,
          attributes_for(:item, id: 100, bucketlist_id: 100)
        )
      end

      it "returns status code of 400" do
        expect(response.status).to eq 400
      end

      it "returns an error message" do
        expect(json(response.body)[:error]).to eq "Request cannot be completed"
      end
    end
  end

  describe "DELETE destroy" do
    context "when making a valid delete request" do
      it "should decrease item count by 1" do
        expect do
          delete :destroy, bucketlist_id: @item.bucketlist.id, id: @item.id
        end.to change(Item, :count).by(-1)
      end
    end

    context "when making an invalid delete request" do
      before(:each) do
        item = create(:item)
        params = {
          id: item.id,
          bucketlist_id: item.bucketlist.id
        }

        delete :destroy, params
      end

      it "returns a status code of 400" do
        expect(response.status).to eq 400
      end

      it "returns an error message" do
        expect(json(response.body)[:error]).to eq "Request cannot be completed"
      end
    end
  end
end
