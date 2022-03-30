class CreateTodoLists < ActiveRecord::Migration[7.0]
  def change
    create_table :todo_lists do |t|
      t.string :title, null: false. unique: true
      t.integer :items_count, default: 0
      t.boolean :finished, default: false, null: false

      t.timestamps
    end
  end
end
