module Api
  module V1
    class ItemsController < ApplicationController
      before_action :authenticate_token

      def create
        bucketlist = current_user.bucketlists.find_by(
          id: params[:bucketlist_id]
        )

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
    end
  end
end
