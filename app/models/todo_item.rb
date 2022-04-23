class TodoItem < ApplicationRecord
  belongs_to :todo

  enum status: { new: 0, read: 1, executed: 2 }
end
