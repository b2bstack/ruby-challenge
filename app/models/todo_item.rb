class TodoItem < ApplicationRecord
  paginates_per 10

  belongs_to :todo

  enum status: { newer: 0, readed: 1, executed: 2, archived: 3 }, _prefix: :status, _default: :newer

  validates :description, presence: true
  validates :todo_id, presence: true
end
