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
    render json: { error: language.invalid_request }, status: 400
  end

  def update_helper(object, params)
    if object.update_attributes(params)
      render json: object, status: 200
    else
      render json: { errors: object.errors }, status: 422
    end
  end

  def save_helper(object)
    if object.save
      render json: object, status: 201
    else
      render json: { errors: object.errors }, status: 422
    end
  end

  def delete_helper(object)
    object.destroy
    render json: { success: language.delete_message(object) }, status: 200
  end
end
