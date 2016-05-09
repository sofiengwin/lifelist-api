class BucketlistSerializer < ActiveModel::Serializer
  self.root = false

  attributes :id, :name, :items, :date_created, :date_modified, :created_by

  has_many :items

  def date_created
    object.created_at.strftime("%Y-%m-%d %H:%M:%S")
  end

  def date_modified
    object.updated_at.strftime("%Y-%m-%d %H:%M:%S")
  end

  def created_by
    object.user_id
  end
end
