class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :action, :mode, :created_at, :updated_at, :todo_list_id
end