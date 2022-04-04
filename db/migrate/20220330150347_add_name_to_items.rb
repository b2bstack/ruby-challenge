class AddNameToItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :name, :string
  end
end
