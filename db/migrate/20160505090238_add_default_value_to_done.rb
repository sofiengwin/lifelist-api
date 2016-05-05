class AddDefaultValueToDone < ActiveRecord::Migration
  def change
    change_column :items, :done, :boolean, default: true
  end
end
