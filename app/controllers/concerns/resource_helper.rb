module ResourceHelper
  extend ActiveSupport::Concern

  included do
    before_action :validate_bucketlist_and_item, except: [:create, :index]
  end

  # def validate_bucketlist
  #   @bucketlist = current_user.bucketlists.find_by(id: params[:id])
  #   return not_found unless @bucketlist
  # end

  def validate_bucketlist_and_item
    id = params[:controller] == "api/v1/items" ? params[:bucketlist_id] : params[:id]
    @bucketlist = current_user.bucketlists.find_by(id: id)
    return not_found unless @bucketlist

    bucketlist_item if params[:controller] == "api/v1/items"
  end

  def bucketlist_item
    @item = @bucketlist.items.find_by(id: params[:id])
    return not_found unless @item
  end

  def not_found
    render json: { error: "Request cannot be completed" }, status: 400
  end
end
