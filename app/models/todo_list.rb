class TodoList < ApplicationRecord
    belongs_to :user
    validates :title, presence: true, uniqueness: true
    has_many :items, dependent: :destroy
    enum mode: [:pending, :intiated, :done]
    MODE_ORDERS = [ 
                  [1, 2, 0],
                  [2, 0, 1],
                  [0, 1, 2],
                  [1, 0, 2],
                  [2, 1, 0],
                  [0, 2, 1]
                          ]

                    
            
                    
    def mode_order(factor)
        self.in_order_of(:mode, MODE_ORDERS[factor])
    end
            

    def active_items
        self.items.where.not(mode: :archived)
    end
end
