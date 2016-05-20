module Api
  module V1
    class BucketlistsController < ApplicationController
      before_action :authenticate_token
      include ResourceHelper
      skip_before_action :confirm_ownership, only: [:index, :create]

      def index
        bucketlists = current_user.bucketlists.search(params[:q]).
                      paginate(params)
        if bucketlists.empty?
          render json: { error: language.no_record_found }, status: 404
        else
          render json: bucketlists, status: 200, root: false
        end
      end

      def show
        render json: @bucketlist, status: 200
      end

      def create
        bucketlist = current_user.bucketlists.new(bucketlist_params)
        save_helper(bucketlist)
      end

      def update
        update_helper(@bucketlist, bucketlist_params)
      end

      def destroy
        delete_helper(@bucketlist)
      end

      private

      def bucketlist_params
        params.permit(:name)
      end
    end
  end
end
