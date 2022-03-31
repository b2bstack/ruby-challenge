class Item < ApplicationRecord
  belongs_to :todo_list, counter_cache: true
  validates :name, presence: true
  validates :action, presence: true
  validates :mode, presence: true
  enum mode: [:pending, :readed, :executed, :archived]

end
