class ItemsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_todo_list, only: [:index, :create]
    before_action :set_item, only: [:show, :update, :destroy]

    # GET /items
    def index
        if @todo_list && @todo_list.user == current_user
            @items = @todo_list.items
            render json: @items, each_serializer: ItemSerializer
        else
            render json: { error: 'Todo list not found' }, status: :not_found 
        end
    end

    # GET /items/1
    def show
        if @item && @item.todo_list.user == current_user
            render json: @item
        else
            render json: { error: 'Item not found' }, status: :not_found
        end
    end

    # POST /items
    def create
        begin
            @item = Item.new(item_params)
            @item.mode = :pending

            if @item.save && @item.todo_list.user == current_user
                render json: @item, status: :created, location: @item
            else
                render json: @item.errors, status: :unprocessable_entity
            end
        rescue ActionController::ParameterMissing => e
            render json: { error: e.message }, status: :unprocessable_entity
        end
    end

    # PATCH/PUT /items/1
    def update
        if @item.update(item_params)
            render json: @item
        else
            render json: @item.errors, status: :unprocessable_entity
        end
    end

    # DELETE /items/1
    def destroy
        @item.destroy
    end

    private

    def set_todo_list
        if params[:todo_list_id]
            begin 
                @todo_list = TodoList.find(params[:todo_list_id])
            rescue ActiveRecord::RecordNotFound => e
                render json: { error: 'Todo list not found' }, status: :not_found
            end
        end
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_item
        begin
            @item = Item.find(params[:id])
        rescue ActiveRecord::RecordNotFound => e
            render json: { error: 'Item not found' }, status: :not_found
        end
    end

    # Only allow a trusted parameter "white list" through.
    def item_params
        params.require(:item).permit(:name, :todo_list_id, :action)
    end
end

