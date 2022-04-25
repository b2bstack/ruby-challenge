class Todo < ApplicationRecord
  paginates_per 10

  belongs_to :user
  has_many :todo_items, dependent: :destroy

  validates :title, presence: true
  validates :user_id, presence: true
end
