module Api
  module V1
    class SessionsController < ApplicationController
      def create
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
          user.update_attribute("status", true)
          token = AuthToken.new.encode(user.id)
          render(
            json: { success: "Logged in successfully", auth_token: token },
            status: 200
          )
        else
          render json: { error: "Unable to login" }, status: 422
        end
      end
    end
  end
end
