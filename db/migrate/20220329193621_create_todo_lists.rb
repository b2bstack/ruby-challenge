class CreateTodoLists < ActiveRecord::Migration[7.0]
  def change
    create_table :todo_lists do |t|
      t.string :title, null: false. unique: true
      t.integer :items_count
      t.boolean :finished

      t.timestamps
    end
  end
end
