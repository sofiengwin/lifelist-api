class ApplicationController < ActionController::API

  def current_user
    @current_user || User.find(user_id) if user_id
  end

  def user_id
    AuthToken.new.decode(get_token)[0]["user"] if get_token
  end

  def authenticate_token
    render(
      json: { error: "Access denied" },
      status: 401
    ) unless current_user && current_user.status
  end

  def get_token
    if request.headers["Authorization"].present?
      request.headers["Authorization"].split(" ").last
    end
  end
end
