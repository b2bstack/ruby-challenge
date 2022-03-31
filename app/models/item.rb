class Item < ApplicationRecord
  belongs_to :todo_list, counter_cache: true
  validates :name, presence: true
  validates :action, presence: true
  enum mode: [:pending, :read, :executed, :archived]
  MODE_ORDER= [ [1, 2, 3, 4],
                [2, 3, 4, 1],
                [3, 4, 1, 2],
                [4, 1, 2, 3],
                [1, 3, 2, 4],
                [2, 1, 4, 3],
                [3, 2, 1, 4],
                [4, 3, 2, 1],
                [1, 4, 3, 2],
                [2, 4, 1, 3],
                [3, 1, 4, 2],
                [4, 2, 1, 3],
                [1, 3, 4, 2],
                [2, 3, 1, 4],
                [3, 4, 2, 1],
                [4, 1, 3, 2],
                [1, 2, 4, 3],
                [2, 1, 3, 4],
                [3, 2, 4, 1],
                [4, 3, 1, 2] ]
    

  def self.mode_order(factor)
    self.in_order_of(:mode, MODE_ORDER[factor])
  end

end
