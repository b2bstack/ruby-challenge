class CreateTodoLists < ActiveRecord::Migration[7.0]
  def change
    create_table :todo_lists do |t|
      t.string :title, null: false
      t.integer :items_count, default: 0

      t.timestamps
    end
  end
end
