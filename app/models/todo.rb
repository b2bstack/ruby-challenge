class Todo < ApplicationRecord
  belongs_to :user
  has_many :todo_items, dependent: :destroy

  validates :title, presence: true
  validates :user_id, presence: true
end
