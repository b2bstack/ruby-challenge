class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.references :todo_list, null: false, foreign_key: true
      t.string :action
      t.integer :mode, default: 0, null: false

      t.timestamps
    end
  end
end
