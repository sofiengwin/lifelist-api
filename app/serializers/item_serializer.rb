class ItemSerializer < ActiveModel::Serializer
  self.root = false

  attributes :id, :name, :date_created, :date_modified, :done

  def date_created
    object.created_at.strftime("%Y-%m-%d %H:%M:%S")
  end

  def date_modified
    object.updated_at.strftime("%Y-%m-%d %H:%M:%S")
  end
end
