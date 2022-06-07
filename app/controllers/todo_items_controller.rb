# frozen_string_literal: true

class ::TodoItemsController < ::ApplicationController
  rescue_from ::ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ::Pagy::VariableError, with: :pagination_param_not_allowed

  before_action :set_todo_item, only: %i[ show update destroy ]

  PAGINATION_PER_PAGE = 25

  # GET /todo_items
  def index
    model = ::TodoItem.with_softdelete
                      .with_filters(index_filters_params)
                      .search_by_title(index_filters_params)
                      .order(weight: :asc)

    @meta, @records = pagy(model, items: pagination_per_page)

    render json: { data: @records, meta: @meta }
  end

  # GET /todo_items/1
  def show
    render json: @todo_item
  end

  # POST /todo_items
  def create
    @todo_item = ::TodoItem.new(todo_item_params)

    if @todo_item.save
      render json: @todo_item, status: :created, location: @todo_item
    else
      render json: @todo_item.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /todo_items/1
  def update
    if @todo_item.update(todo_item_params)
      render json: @todo_item
    else
      render json: @todo_item.errors, status: :unprocessable_entity
    end
  end

  # DELETE /todo_items/1
  def destroy
    # @todo_item.destroy
    @todo_item.update(deleted_at: Time.zone.now)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_todo_item
      @todo_item = ::TodoItem.with_softdelete.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def todo_item_params
      params.permit(:is_archived,
                    :is_readed,
                    :is_executed,
                    :weight,
                    :title,
                    :description)
    end

    def index_filters_params
      params.permit(:is_archived,
                    :is_readed,
                    :is_executed,
                    :weight,
                    :title,
                    :description,
                    :page,
                    :per_page)
    end

    def pagination_per_page
      default = PAGINATION_PER_PAGE

      if params[:per_page].blank? || params[:per_page].to_i > default
        return default
      end

      params[:per_page]&.to_i || default
    end

    def not_found
      render json: { errors: ['Record not exists.'] }, status: :not_found
    end

    def pagination_param_not_allowed
      params[:page] = 1 if params[:page].to_i.zero?
      params[:per_page] = PAGINATION_PER_PAGE if params[:per_page].to_i.zero?

      index
    end
end
