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
          render json: { error: "No bucketlist found" }, status: 404
        else
          render json: bucketlists, status: 200, root: false
        end
      end

      def show
        render json: @bucketlist, status: 200
      end

      def create
        bucketlist = current_user.bucketlists.new(bucketlist_params)
        if bucketlist.save
          render json: bucketlist, status: 201
        else
          render json: { errors: bucketlist.errors }, status: 422
        end
      end

      def update
        if @bucketlist.update_attributes(bucketlist_params)
          render json: @bucketlist, status: 200
        else
          render json: { errors: @bucketlist.errors }, status: 422
        end
      end

      def destroy
        @bucketlist.destroy
        render json: { notice: "bucketlist deleted" }, status: 200
      end

      private

      def bucketlist_params
        params.permit(:name)
      end
    end
  end
end
