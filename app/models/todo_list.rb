class TodoList < ApplicationRecord
    belongs_to :user
    validates :title, presence: true, uniqueness: true
    has_many :items, dependent: :destroy
    enum mode: [:pending, :readed, :done, :archived]
end
