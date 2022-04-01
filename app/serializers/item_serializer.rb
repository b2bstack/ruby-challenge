class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :action, :mode, :created_at, :updated_at, :todo_list

  def todo_list
    self.object.todo_list.title
  end
end