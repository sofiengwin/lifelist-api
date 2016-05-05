module Api
  module V1
    class ItemsController < ApplicationController
      include ResourceHelper
      before_action :authenticate_token
      before_action :confirm_ownership, only: [:update, :destroy]

      def create
        bucketlist = current_user.bucketlists.find_by(
          id: params[:bucketlist_id]
        )
        return not_found unless bucketlist
        item = bucketlist.items.new(item_params)
        if item.save
          render json: item, status: 201
        else
          render json: { error: "Unable to create new item" }, status: 422
        end
      end

      def update
        item = Item.find_by(id: params[:id])
        if item.update(item_params)
          render json: item, status: 200
        else
          render json: { error: "Unable to edit item" }, status: 422
        end
      end

      def destroy
        item = Item.find_by(id: params[:id])
        item.destroy
        render json: { success: "Item deleted successfully" }, status: 200
      end

      private

      def item_params
        params.require(:item).permit(:name, :done)
      end

      def confirm_ownership
        bucketlist = current_user.bucketlists.find_by(
          id: params[:bucketlist_id]
        )

        return not_found unless bucketlist

        item = bucketlist.items.find_by(id: params[:id])

        return not_found unless item
      end
    end
  end
end
