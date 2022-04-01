class TodoListsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_todo_list, only: [:show, :edit, :update, :destroy]
    after_action { pagy_headers_merge(@pagy) if @pagy }


    def index
       if params[:filter] == 'mode_desc'
            @pagy, @todo_lists = pagy(current_user.todo_lists.order(mode: :desc), items: 10)
           
       elsif params[:filter] == 'mode_asc'
            @pagy, @todo_lists = pagy(current_user.todo_lists.order(mode: :asc), items: 10)
           
       elsif params[:filter] == 'mode_pending_only'
            @pagy, @todo_lists = pagy(current_user.todo_lists.where(mode: 0), items: 10)
           
       elsif params[:filter] == 'mode_initiated_only'
            @pagy, @todo_lists = pagy(current_user.todo_lists.where(mode: 1), items: 10)
           
       elsif params[:filter] == 'mode_done_only'
            @pagy, @todo_lists = pagy(current_user.todo_lists.where(mode: 2), items: 10)
           
       elsif params[:filter_factor] == params[:filter_factor].to_i.to_s && params[:filter_factor].to_i >= 0 && params[:filter_factor].to_i <= 5
            @pagy, @todo_lists = pagy(TodoList.where_ordered_by_mode(params[:filter_factor].to_i, current_user), items: 10)
       else
            @pagy, @todo_lists = pagy(current_user.todo_lists, items: 10)
       end
           
        render json: @todo_lists
    end

    def show
        if @todo_list.user == current_user
           if params[:initiated] == 'true'
            @todo_list.update(mode: :intiated)     
           elsif params[:done] == 'true'
            @todo_list.update(mode: :done)
           end
            render json: @todo_list
        else
            render json: { errors: { 'todo_list' => ['is not found'] } }, status: :not_found
        end
    end

    def create
        todo_list = TodoList.new(todo_list_params)
        todo_list.user = current_user
        todo_list.mode = :pending


        if todo_list.save
            render json:  todo_list, serializer: TodoListSerializer
        else
            render json: { errors: todo_list.errors }, status: :unprocessable_entity
        end
    end

    def destroy
        if @todo_list.user == current_user
            if @todo_list.destroy
                render json: { message: 'Todo list deleted successfully' }, status: :ok
            else
                render json: { error: 'Todo list not deleted' }, status: :unprocessable_entity
            end
        else
            render json: { error: 'Todo list not found' }, status: :not_found
        end
    end


    private

    def todo_list_params
        params.require(:todo_list).permit(:title, :description)
    end

    def set_todo_list
        begin
            @todo_list = TodoList.find(params[:id])
        rescue ActiveRecord::RecordNotFound => e
            puts e 
            render json: { error: 'Todo list not Found' }, status: :not_found
        end
    end

end