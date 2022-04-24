class Api::V1::TodoItemsController < ApplicationController
  before_action :authorize_request
  before_action -> {
    validate_current_user(params[:user_id])
  }, only: %i[show create update destroy]
  before_action :current_todo_item, only: %i[show create update destroy archive execute set_status]

  resource_description do
    short 'Item belongs to a todo list'
    formats [:json]
  end

  api :GET, "/v1/users/:user_id/todos/:todo_id/todo_items/:id", "Show one todo item"
  header "Authorization", "define the token", required: true
  # Show one todo item
  def show
    if @current_todo_item
      # Define status readed is status is newer
      @current_todo_item.status_readed! if @current_todo_item.status_newer?

      render json: {
        todo_item: {
          id: @current_todo_item.id,
          description: @current_todo_item.description,
          status: @current_todo_item.status
        }
      }, status: :ok
    else
      render json: {
        error: "Todo item not found"
      }, status: :not_found
    end
  end

  api :POST, "/v1/users/:user_id/todos/:todo_id/items", "Create new todo item"
  header "Authorization", "Define the token", required: true
  param :description, String, desc: "Description of todo item", required: true
  # Create new todo item
  def create
    @current_todo_item = @current_todo.todo_items.create(todo_item_params)
    if @current_todo_item
      render json: {
        todo_item: {
          id: @current_todo_item.id,
          description: @current_todo_item.description,
          status: @current_todo_item.status
        }
      }, status: :ok
    else
      render json: {
        error: @current_todo_item.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  api :PATCH, "/v1/users/:user_id/todos/:todo_id/items/:id", "Update todo item"
  header "Authorization", "Define the token", required: true
  param :description, String, desc: "Description of todo item", required: true
  param :status, String, desc: "Status of todo item", required: false
  # Update todo item
  def update
    if @current_todo_item.update(todo_item_params)
      render json: {
        todo_item: {
          id: @current_todo_item.id,
          description: @current_todo_item.description,
          status: @current_todo_item.status
        }
      }, status: :ok
    else
      render json: {
        error: @current_todo_item.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  api :DELETE, "/v1/users/:user_id/todos/:todo_id/items/:id", "Remove todo item"
  header "Authorization", "Define the token", required: true
  # Remove todo item
  def destroy
    if @current_todo_item.destroy
      render json: {
        message: "Item #{@current_todo_item.description} successfully removed"
      }, status: :ok
    else
      render json: {
        error: @current_todo_item.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  api :POST, "/v1/users/:user_id/todos/:todo_id/items/:id/archive", "Archive the todo item"
  header "Authorization", "Define the token", required: true
  # Archive the todo item
  def archive
    if @current_todo_item
      @current_todo_item.status_archived!
      render json: {
        todo_item: {
          id: @current_todo_item.id,
          description: @current_todo_item.description,
          status: @current_todo_item.status
        }
      }, status: :ok
    else
      render json: {
        error: @current_todo_item.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  api :POST, "/v1/users/:user_id/todos/:todo_id/items/:id/execute", "Execute the todo item"
  header "Authorization", "Define the token", required: true
  # Execute the todo item
  def execute
    if @current_todo_item
      @current_todo_item.status_executed!
      render json: {
        todo_item: {
          id: @current_todo_item.id,
          description: @current_todo_item.description,
          status: @current_todo_item.status
        }
      }, status: :ok
    else
      render json: {
        error: @current_todo_item.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  api :POST, "/v1/users/:user_id/todos/:todo_id/items/:id/set_status", "Complete todo item"
  header "Authorization", "Define the token", required: true
  param :status, TodoItem.statuses.keys, desc: "Statuses of todo item", required: true
  # Define any status
  def set_status
    if @current_todo_item.update(status: params[:status])
      render json: {
        todo_item: {
          id: @current_todo_item.id,
          description: @current_todo_item.description,
          status: @current_todo_item.status
        }
      }, status: :ok
    else
      render json: {
        error: @current_todo_item.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  private

  def current_todo_item
    @current_todo ||= current_user.todos.find_by_id(params[:todo_id])

    @current_todo_item ||= @current_todo.todo_items.find_by_id(params[:id])
  end

  def todo_item_params
    params.require(:todo_item).permit(:description, :status)
  end
end
