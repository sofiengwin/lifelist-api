module ResourceHelper
  extend ActiveSupport::Concern

  included do
    before_action :confirm_ownership
    before_action :bucketlist_item if controller_name == "items"
  end

  def confirm_ownership
    id = controller_name == "items" ? params[:bucketlist_id] : params[:id]
    @bucketlist = current_user.bucketlists.find_by(id: id)
    return not_found unless @bucketlist
  end

  def bucketlist_item
    @item = @bucketlist.items.find_by(id: params[:id])
    return not_found unless @item
  end

  def not_found
    render json: { error: "Request cannot be completed" }, status: 400
  end
end
