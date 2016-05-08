module Api
  module V1
    class BucketlistsController < ApplicationController
      include ResourceHelper

      before_action :authenticate_token

      def index
        bucketlists = current_user.bucketlists.search(
          params[:q]
        ).paginate(params)

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
          render(
            json: bucketlist,
            status: 201,
            location: [:api, :v1, bucketlist]
          )
        else
          render json: { errors: bucketlist.errors }, status: 422
        end
      end

      def update
        # bucketlist = current_user.bucketlists.find_by(id: params[:id])
        # return not_found unless bucketlist
        if @bucketlist.update_attributes(bucketlist_params)
          render json: @bucketlist, status: 200
        else
          render json: { errors: @bucketlist.errors }, status: 422
        end
      end

      def destroy
        # bucketlist = current_user.bucketlists.find_by(id: params[:id])
        # return not_found unless bucketlist
        @bucketlist.destroy
        render json: { notice: "bucketlist deleted" }, status: 200
      end

      private

      def bucketlist_params
        params.require(:bucketlist).permit(:name, :user_id)
      end
    end
  end
end
