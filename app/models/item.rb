class Item < ApplicationRecord
  belongs_to :todo_list, counter_cache: true
  validates :name, presence: true
  validates :action, presence: true
  enum mode: [:pending, :read, :executed, :archived]
end
