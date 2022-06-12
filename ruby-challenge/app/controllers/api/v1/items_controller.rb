class Api::V1::ItemsController < Api::V1::ApiController
 before_action :set_item, only: [:show, :update, :destroy]

 # GET /api/v1/items.json
 def index
   @items = params[:status] ? Item.where(status: params[:status]) : Item.all
   render json: @items.order(:status).page(params[:page] ||= 1)
 end

 # GET /api/v1/items/1.json
 def show
   render json: @item
 end

 # POST /api/v1/items.json
 def create
   @item = Item.new(item_params)
   if @item.save
     render json: @item, status: :created
   else
     render json: @item.errors, status: :unprocessable_entity
   end
 end

 # PATCH/PUT /api/v1/items/1.json
 def update
   if @item.update(item_params)
     render json: @item
   else
     render json: @item.errors, status: :unprocessable_entity
   end
 end

 # DELETE /api/v1/items/1.json
 def destroy
   @item.destroy
 end

 private
   # Use callbacks to share common setup or constraints between actions.

   def set_item
     @item = Item.find(params[:id])
   end

   # Only allow a trusted parameter "white list" through.
   def item_params
     params.permit(:name, :description, :status)
   end

end
