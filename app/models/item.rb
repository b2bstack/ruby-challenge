class Item < ApplicationRecord
  belongs_to :todo_list, counter_cache: true
  validates :name, presence: true
  validates :action, presence: true
  enum mode: [:pending, :read, :executed, :archived]
  MODE_ORDER= [ [1, 2, 3, 0],
                [2, 3, 0, 1],
                [3, 0, 1, 2],
                [0, 1, 2, 3],
                [1, 3, 2, 0],
                [2, 1, 0, 3],
                [3, 2, 1, 0],
                [0, 3, 2, 1],
                [1, 0, 3, 2],
                [2, 0, 1, 3],
                [3, 1, 0, 2],
                [0, 2, 1, 3],
                [1, 3, 0, 2],
                [2, 3, 1, 0],
                [3, 0, 2, 1],
                [0, 1, 3, 2],
                [1, 2, 0, 3],
                [2, 1, 3, 0],
                [3, 2, 0, 1],
                [0, 3, 1, 2],
                [1, 0, 2, 3],
                [2, 0, 3, 1],
                [3, 1, 2, 0],
                [0, 2, 3, 1] ]
    
  # use in order of instead of scope
  def self.mode_order(factor)
    self.in_order_of(:mode, MODE_ORDER[factor])
  end

end
