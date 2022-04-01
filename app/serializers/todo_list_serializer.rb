class TodoListSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :mode, :created_at, :updated_at, :items_count
  # has_many :items dont will be used in this project
end