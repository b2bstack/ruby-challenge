class TodoListsController < ApplicationController
    before_action :set_todo_list, only: [:show, :edit, :update, :destroy]


    def index

    end

    def show

    end

    def create


        todo_list = TodoList.new(todo_list_params)


        if todo_list.save
            render json: { todo_list: todo_list }
        else
            render json: { errors: todo_list.errors }, status: :unprocessable_entity
        end


    end

    def edit

    end

    def update

    end


    private

    def todo_list_params
        params.require(:todo_list).permit(:title, :description)
    end

    def set_todo_list
        @todo_list = TodoList.find(params[:id])
    end

end