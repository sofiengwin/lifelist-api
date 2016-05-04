require "rails_helper"

RSpec.describe Api::V1::ItemsController, type: :controller do
  before(:all) do
    @item = create(:item)
    @user = @item.bucketlist.user
    @user.update_attributes(status: true)
    @params = {
      item: attributes_for(:item),
      id: @item.id,
      bucketlist_id: @item.bucketlist.id
    }
  end

  before(:each) do
    allow_any_instance_of(ApplicationController).
    to receive(:current_user).and_return(@user)
  end

  describe "POST create" do
    context "creating an item with valid details" do
      it "should increase item count by 1" do
        expect do
          post :create, @params
        end.to change(Item, :count).by(1)
      end
    end

    context "creating an item with invalid details" do
      it "should not increase item count" do
        params = {
          item: attributes_for(:item, name: nil),
          bucketlist_id: @item.bucketlist.id
        }
        expect do
          post :create, params
        end.to change(Item, :count).by(0)
      end
    end
  end

  describe "PUT update" do
    context "valid update request" do
      it "returns status code of 200" do
        put :update, @params
        expect(response.status).to eq 200
      end
    end

    context "invalid update request" do
      before(:each) do
        put(
          :update,
          { bucketlist_id: 100, id: 100, item: attributes_for(:item) }
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
    context "valid delete request" do
      it "should decrease item count by 1" do
        expect do
          delete :destroy, @params
        end.to change(Item, :count).by(-1)
      end
    end

    context "invalid delete request" do
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
