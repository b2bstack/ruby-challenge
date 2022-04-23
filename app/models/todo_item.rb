class TodoItem < ApplicationRecord
  belongs_to :todo

  enum status: { pending: 0, done: 1 }
end
