module Api
  module V1
    class SessionsController < ApplicationController
      before_action :authenticate_token, except: :create

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

      def destroy
        current_user.update_attribute("status", false)
        render json: { success: "You are now logged out" }
      end
    end
  end
end
