# frozen_string_literal: true

class CreateTodoItems < ActiveRecord::Migration[7.0]
  def change
    create_table :todo_items do |t|
      t.boolean :is_archived
      t.boolean :is_readed
      t.boolean :is_executed
      t.integer :weight
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
