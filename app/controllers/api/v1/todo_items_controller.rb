class Api::V1::TodoItemsController < ApplicationController
  before_action :authorize_request
  before_action -> {
    validate_current_user(params[:user_id])
  }, only: %i[show create update destroy]
  before_action :current_todo, only: %i[create update destroy]

  resource_description do
    short 'Item belongs to a todo list'
    formats [:json]
  end

  api :POST, "/v1/users/:id/todos/:id/items", "Create new todo item"
  header "Authorization", "Define the token", required: true
  param :description, String, desc: "Description of todo item", required: true
  # Create new todo item
  def create
    todo_item = @current_todo.todo_items.new(todo_item_params)

    if todo_item.save
      render json: {
        todo_item: {
          description: todo_item.description,
          status: todo_item.status
        }
      }, status: :ok
    else
      render json: {
        error: todo_item.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  api :PATCH, "/v1/users/:id/todos/:id/items/:id", "Update todo item"
  header "Authorization", "Define the token", required: true
  param :description, String, desc: "Description of todo item", required: true
  param :status, String, desc: "Status of todo item", required: false
  # Update todo item
  def update
    todo_item = @current_todo.todo_items.find_by_id(params[:id])

    if todo_item.update(todo_item_params)
      render json: {
        todo_item: {
          description: todo_item.description,
          status: todo_item.status
        }
      }, status: :ok
    else
      render json: {
        error: todo_item.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  api :DELETE, "/v1/users/:id/todos/:id/items/:id", "Remove todo item"
  header "Authorization", "Define the token", required: true
  # Remove todo item
  def destroy
    todo_item = @current_todo.todo_items.find_by_id(params[:id])

    if todo_item.destroy
      render json: {
        message: "Item #{todo_item.description} successfully removed"
      }, status: :ok
    else
      render json: {
        error: todo_item.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  api :POST, "/v1/users/:id/todos/:id/items/:id/archive", "Archive the todo item"
  header "Authorization", "Define the token", required: true
  # Archive the todo item
  def archive
    if update_status(:archived)
      render json: {
        todo_item: {
          status: todo_item.status
        }
      }, status: :ok
    else
      render json: {
        error: todo_item.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  api :POST, "/v1/users/:id/todos/:id/items/:id/set_status", "Complete todo item"
  header "Authorization", "Define the token", required: true
  param :status, TodoItem.statuses.keys, desc: "Statuses of todo item", required: true
  # Define any status
  def set_status
    if update_status(params[:status])
      render json: {
        todo_item: {
          status: todo_item.status
        }
      }, status: :ok
    else
      render json: {
        error: todo_item.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  private

  def update_status(sts)
    todo_item = @current_todo.todo_items.find_by_id(params[:id])

    todo_item.update(status: sts)
  end

  def current_todo
    @current_todo ||= current_user.todos.find_by_id(params[:todo_id])
  end

  def todo_item_params
    params.require(:todo_item).permit(:description, :status)
  end
end
