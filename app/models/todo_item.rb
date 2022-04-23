class TodoItem < ApplicationRecord
  belongs_to :todo

  enum status: { new: 0, readed: 1, executed: 2 }, _prefix: :status, _default: :new

  validates :description, presence: true
  validates :todo_id, presence: true
end
