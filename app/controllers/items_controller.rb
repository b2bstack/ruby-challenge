class ItemsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_todo_list, only: [:index, :create]
    before_action :set_item, only: [:show, :update, :destroy]
    after_action { pagy_headers_merge(@pagy) if @pagy }
    # GET /items
    def index
        if @todo_list && @todo_list.user == current_user
            collection_serializer = ActiveModel::Serializer::CollectionSerializer

            if params[:filter] == 'mode_desc'
                @pagy, @items = pagy(@todo_list.active_items.order(mode: :desc), items: 40)
            elsif params[:filter] == 'mode_asc'
                @pagy, @items = pagy(@todo_list.active_items.order(mode: :asc), items: 40)
            elsif params[:filter] == 'mode_pending_only'
                @pagy, @items = pagy(@todo_list.items.where(mode: 0), items: 40)
            elsif params[:filter] == 'mode_read_only'
                @pagy, @items = pagy(@todo_list.items.where(mode: 1), items: 40)
            elsif params[:filter] == 'mode_executed_only'
                @pagy, @items = pagy(@todo_list.items.where(mode: 2), items: 40)
            elsif params[:filter] == 'mode_archived_only'
                @pagy, @items = pagy(@todo_list.items.where(mode: 3), items: 40)
            elsif params[:filter_factor] == params[:filter_factor].to_i.to_s && params[:filter_factor].to_i >= 0 && params[:filter_factor].to_i <= 19
                @pagy, @items = pagy(@todo_list.active_items.mode_order(params[:filter_factor].to_i), items: 40)
            else
                @pagy, @items = pagy(@todo_list.active_items, items: 40)
            end

            render json: { todo_list: TodoListSerializer.new(@todo_list).as_json, items: collection_serializer.new(@items, each_serializer: ItemSerializer).as_json }
        else
            render json: { error: 'Todo list not found' }, status: :not_found 
        end
    end

    # GET /items/1
    def show
        if @item && @item.todo_list.user == current_user

            
            @item.update(mode: :read)
            

            if params[:executed] == 'true'

                @item.update(mode: :executed)

            elsif params[:archived] == 'true'

                @item.update(mode: :archived)
                
            end

            render json: @item, serializer: ItemSerializer
        else
            render json: { error: 'Item not found' }, status: :not_found
        end
    end

    # POST /items
    def create
        begin
            @item = Item.new(item_params)
            @item.mode = :pending    # default

            if @item.save && @item.todo_list.user == current_user
                if @item.todo_list.mode == :pending || @item.todo_list.mode == :executed
                    @item.todo_list.update(mode: :intiated)
                end
                render json: { item: ItemSerializer.new(@item).as_json }, status: :created, location: @item
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
        if @item.todo_list.user == current_user
            if @item.destroy
                render json: { message: 'Item deleted' }
            else
                render json: { error: 'Item not deleted' }, status: :unprocessable_entity
            end
        else 
            render json: { error: 'Item not found' }, status: :not_found
        end
    end

    private

    def set_todo_list
        if params[:todo_list_id] && params[:action] != 'show'
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

