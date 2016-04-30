class AddStatusToUsers < ActiveRecord::Migration
  def change
    add_column :users, :status, :boolean, default:false
  end
end
