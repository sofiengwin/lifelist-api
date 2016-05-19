module Api
  module V1
    class ItemsController < ApplicationController
      before_action :authenticate_token
      include ResourceHelper
      skip_before_action :bucketlist_item, only: [:create]

      def create
        item = @bucketlist.items.new(item_params)
        save_helper(item)
      end

      def update
        update_helper(@item, item_params)
      end

      def destroy
        delete_helper(@item)
      end

      private

      def item_params
        params.permit(:name, :done)
      end
    end
  end
end
