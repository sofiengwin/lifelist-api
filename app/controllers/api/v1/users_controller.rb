module Api
  module V1
    class UsersController < ApplicationController
      def create
        user = User.new(user_params)
        if user.save
          render(
            json: user,
            status: 201, location: [:api, :v1, user]
          )
        else
          render json: { errors: user.errors }, status: 422
        end
      end

      def user_params
        params.require(:user).permit(
          :name,
          :email,
          :password,
          :password_confirmation
        )
      end
    end
  end
end
