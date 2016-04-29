module Api
  module V1
    class UsersController < ApplicationController
      def create
        user = User.new(user_params)
        if user.save
          render(
            json: { success: "Account successfully created" },
            status: 201, location: [:api, :v1, user]
          )
        end
      end
    end
  end
end
