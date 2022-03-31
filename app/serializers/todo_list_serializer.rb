class TodoListSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :mode,:created_at, :updated_at, :items_count
end