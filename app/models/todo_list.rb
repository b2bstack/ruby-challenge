class TodoList < ApplicationRecord
    belongs_to :user
    validates :title, presence: true, uniqueness: true
    has_many :items, dependent: :destroy
    enum mode: [:pending, :intiated, :done]
    TODO_ORDERS = [ [0, 1, 2],
                    [1, 2, 0],
                    [2, 0, 1],
                    [0, 2, 1],
                    [1, 0, 2],
                    [2, 1, 0] ]
        

    def self.where_ordered_by_mode(factor, user)
        self.where(user_id: user.id).in_order_of(:mode, TODO_ORDERS[factor])
    end

    
    def active_items
        self.items.where.not(mode: :archived)
    end
end
