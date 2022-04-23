class Todo < ApplicationRecord
  belongs_to :user
  has_many :todo_items, dependent: :destroy
end
