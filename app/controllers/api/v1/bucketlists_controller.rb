module Api
  module V1
    class BucketlistsController < ApplicationController
      before_action :authenticate_token

      def index
        bucketlists = current_user.bucketlists.search(params[:search]).paginate(params)
        # binding.pry
        if bucketlists.empty?
          render json: { error: "No bucketlist found" }, status: 404
        else
          render json: bucketlists, status: 200, root: false
        end
      end

      def show
        bucketlist = Bucketlist.find(params[:id])
        render json: bucketlist, status: 200
      end

      def create
        # TODO: handle conditions where an invalid id is passed
        bucketlist = Bucketlist.new(bucketlist_params)
        if bucketlist.save
          render json: bucketlist, status: 201, location: [:api, :v1, bucketlist]
        else
          render json: { errors: bucketlist.errors }, status: 422
        end
      end

      def update
        # TODO: handle conditions where an invalid id is passed
        bucketlist = Bucketlist.find(params[:id])
        if bucketlist.update_attributes(bucketlist_params)
          render json: bucketlist, status: 200
        else
          render json: { errors: bucketlist.errors }, status: 422
        end
      end

      def destroy
        # TODO: handle conditions where an invalid id is passed
        bucketlist = Bucketlist.find(params[:id])
        bucketlist.destroy
        render json: { notice: "bucketlist deleted" }, status: 200
      end

      protected

      def bucketlist_params
        params.require(:bucketlist).permit(:name, :user_id)
      end
    end
  end
end
