module Api
  module V1
    class ItemsController < ApplicationController
      before_action :authenticate_token
      include ResourceHelper
      skip_before_action :bucketlist_item, only: [:create]

      def create
        item = @bucketlist.items.new(item_params)
        if item.save
          render json: item, status: 201
        else
          render json: { errors: item.errors }, status: 422
        end
      end

      def update
        if @item.update_attributes(item_params)
          render json: @item, status: 200
        else
          render json: { errors: @item.errors }, status: 422
        end
      end

      def destroy
        @item.destroy
        render json: { success: "Item deleted successfully" }, status: 200
      end

      private

      def item_params
        params.permit(:name, :done)
      end
    end
  end
end
