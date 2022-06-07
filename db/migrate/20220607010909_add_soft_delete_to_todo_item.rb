class AddSoftDeleteToTodoItem < ActiveRecord::Migration[7.0]
  def change
    add_column :todo_items, :deleted_at, :datetime
    add_index :todo_items, :deleted_at
  end
end
