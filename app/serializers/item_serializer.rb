class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :action, :mode, :created_at, :updated_at
end