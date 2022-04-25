class Api::V1::TodosController < ApplicationController
  before_action :authorize_request
  before_action -> {
    validate_current_user(params[:user_id])
  }, only: %i[show create update destroy]

  resource_description do
    short 'Todo is a list of tasks of you want to do'
    formats [:json]
  end

  api :GET, "/v1/users/:user_id/todos", "Show all todos of a user"
  header "Authorization", "define the token", required: true
  param :status, String, desc: "Filter by status", required: false
  param :page, NumericParam, desc: "Page number", required: false
  # Show all todos
  def index
    todos = current_user.todos.page(current_page)

    render json: {
      todos: todos.map do |todo|
        todo_items = params[:status].present? ?
          todo.todo_items.where(status: params[:status]) : todo.todo_items
        {
          id: todo.id,
          title: todo.title,
          todo_items: todo_items.map do |todo_item|
            {
              description: todo_item.description,
              status: todo_item.status
            }
          end
        }
      end,
      pagination: {
        total_pages: Todo.page.total_pages,
        limit_per_page: Todo.page.limit_value,
        current_page: todos.current_page,
        count_items: todos.count
      }
    }, status: :ok
  end

  api :GET, "/v1/users/:user_id/todos/:id", "Get details of a todo"
  header "Authorization", "define the token", required: true
  param :status, TodoItem.statuses.keys, desc: "Statuses of todo item"
  # Show all todo items of a todo
  def show
    todo = current_user.todos.find_by_id(params[:id])

    if todo
      todo_items = params[:status].present? ?
        todo.todo_items.where(status: params[:status]) : todo.todo_items

      render json: {
        todo: {
          title: todo.title,
          todo_items: todo_items.map do |todo_item|
            {
              id: todo_item.id,
              description: todo_item.description,
              status: todo_item.status
            }
          end
        }
      }, status: :ok
    else
      render json: {
        error: "Todo not found"
      }, status: :not_found
    end
  end

  api :POST, "/v1/users/:user_id/todos", "Create new todo"
  header "Authorization", "Define the token", required: true
  formats ['json']
  param :title, String, required: true, desc: "Title of the todo"
  param :todo_items, Array, desc: "Todo items" do
    param :description, String, desc: "Description of todo item", required: true
    param :status, TodoItem.statuses.keys, desc: "Statuses of todo item", default: TodoItem.statuses.keys.first
  end
  # Create new todo
  def create
    todo = current_user.todos.create(todo_params)

    if params[:todo_items].present?
      params[:todo_items].each do |todo_item|
        todo.todo_items.create(
          todo_item.permit(:description, :status)
        )
      end
    end

    render json: {
      todo: {
        title: todo.title,
        user: todo.user.name,
        todo_items: todo.todo_items.map do |todo_item|
          {
            description: todo_item.description,
            status: todo_item.status
          }
        end
      }
    }, status: :created
  end

  api :PATCH, "/v1/users/:user_id/todos/:id", "Update title of todo"
  header "Authorization", "Define the token", required: true
  param :title, String, required: true, desc: "Title of the todo"
  # Update title of todo
  def update
    todo = current_user.todos.find(params[:id])

    if todo.update(todo_params)
      render json: {
        todo: {
          title: todo.title
        }
      }, status: :ok
    else
      render json: {
        errors: todo.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  api :DELETE, "/v1/users/:user_id/todos/:id", "Remove a todo with all todo items"
  header "Authorization", "Define the token", required: true
  # Remove a todo with all todo items
  def destroy
    todo = current_user.todos.find(params[:id])

    if todo.destroy
      render json: {
        message: "Todo #{todo.title} successfully removed"
      }, status: :ok
    else
      render json: {
        errors: todo.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  api :POST, "/v1/users/:user_id/todos/:id/clear_items", "Clear all todo items"
  header "Authorization", "Define the token", required: true
  # Clear all todo items
  def clear_items
    todo = current_user.todos.find_by_id(params[:id])

    if todo
      if todo.todo_items.destroy_all
        render json: {
          message: "All todo items of #{todo.title} successfully cleared"
        }, status: :ok
      else
        render json: {
          errors: todo.errors.full_messages
        }, status: :unprocessable_entity
      end
    else
      render json: {
        error: "Todo not found"
      }, status: :not_found
    end
  end

  api :GET, "/v1/users/:user_id/todos/by_status", "Filter by status"
  header "Authorization", "Define the token", required: true
  param :status, TodoItem.statuses.keys, desc: "Statuses of todo item", required: false
  param :todo_id, NumericParam, desc: "Id of the todo", required: false
  param :page, NumericParam, desc: "Page number", required: false
  # Filter by status
  def by_status
    todos = params[:todo_id].present? ?
        current_user.todos.page(current_page).where(id: params[:todo_id]) :
        current_user.todos.page(current_page)

    render json: {
      todos: todos.map do |todo|
        todo_items = params[:status].present? ? todo.todo_items.where(status: params[:status]) :
          todo.todo_items
        {
          id: todo.id,
          title: todo.title,
          todo_items: todo_items.map do |todo_item|
            {
              description: todo_item.description,
              status: todo_item.status
            }
          end
        }
      end,
      pagination: {
        total_pages: Todo.page.total_pages,
        limit_per_page: Todo.page.limit_value,
        current_page: todos.current_page,
        count_items: todos.count
      }
    }, status: :ok
  end

  private

  def current_page
    params[:page].present? ? params[:page].to_i : 1
  end

  def todo_params
    params.require(:todo).permit(:title)
  end
end
