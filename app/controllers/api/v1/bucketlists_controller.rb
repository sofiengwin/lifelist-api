module Api
  module V1
    class BucketlistsController < ApplicationController
      def index
        bucketlists = Bucketlist.all
        render json: bucketlists, status: 200
      end

      def show
        bucketlist = Bucketlist.find(params[:id])
        render json: bucketlist, status: 200
      end

      def create
        bucketlist = Bucketlist.new(bucketlist_params)
        if bucketlist.save
          render json: bucketlist, status: 201, location: [:api, :v1, bucketlist]
        else
          render json: bucketlist.errors.full_messages, status: 422
        end
      end

      protected

      def bucketlist_params
        params.require(:bucketlist).permit(:name)
      end
    end
  end
end
