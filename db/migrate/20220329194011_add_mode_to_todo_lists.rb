class AddModeToTodoLists < ActiveRecord::Migration[7.0]
  def change
    add_column :todo_lists, :mode, :integer
  end
end
