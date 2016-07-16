module Api
  module V1
    class UsersController < ApplicationController
      def create
        user = User.new(user_params)
        if user.save
          token = AuthToken.new.encode(user.id)
          render(
            json: {
              message: language.account_created,
              auth_token: token,
              user: user
            },
            status: 201
          )
        else
          render json: { errors: user.errors }, status: 422
        end
      end

      private

      def user_params
        params.permit(
          :name,
          :email,
          :password,
          :password_confirmation,
          :status
        )
      end
    end
  end
end
