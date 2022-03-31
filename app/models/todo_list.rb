class TodoList < ApplicationRecord
    belongs_to :user
    validates :title, presence: true, uniqueness: true
    has_many :items, dependent: :destroy
    enum mode: [:pending, :intiated, :done]


    def active_items
        self.items.where.not(mode: :archived)
    end
end
