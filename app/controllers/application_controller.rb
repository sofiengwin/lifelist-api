class ApplicationController < ActionController::API
  include ActionController::Serialization

  def current_user
    @current_user || User.find_by(id: user_id) if user_id
  end

  def authenticate_token
    render(
      json: { error: language.access_denied },
      status: 401
    ) unless current_user && current_user.status
  end

  def invalid_endpoint
    render(
      json: { error: language.invalid_endpoint_error },
      status: 400
    )
  end

  def language
    Languages.new
  end

  private

  def user_id
    decode_token[0]["user"] unless decode_token.nil?
  end

  def decode_token
    AuthToken.new.decode(get_token) if get_token
  end

  def get_token
    if request.headers["Authorization"].present?
      request.headers["Authorization"].split(" ").last
    end
  end
end
