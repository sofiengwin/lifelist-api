module ResourceHelper
  extend ActiveSupport::Concern

  def not_found
    render json: { error: "Request cannot be completed" }, status: 400
  end
end
