class AddModeToTodoLists < ActiveRecord::Migration[7.0]
  def change
    add_column :todo_lists, :mode, :integer, null: false, default: 0
  end
end
