class ItemsController < ApplicationController

  def index
    @items = Item.style.sellable
    @style = Style.new
    @item = Item.new
    @clearance_batch = ClearanceBatch.new
    respond_to do |format|
      format.html
      format.csv { render text: @items.to_csv }
    end
  end

  def create
		@item = Item.new item_params

		unless item_params.nil?        
	  	@item.save
	  	flash[:notice]  = "Your item was saved."
		end
		redirect_to styles_path(style_id: @item.style_id, item_id: @item.id)
  end

  def update
  	@item = Item.find(params[:id])

		if @item.update item_params
	  	flash[:notice] = "Successfully updated Item."  
	 	end  
	 	redirect_to styles_path(style_id: @item.style_id , item_id: @item.id) 
  end

  private

  def item_params
  	params.require(:item).permit(:size, :color, :sold_price, :status, :style_id, :clearance_batch_id, :sold_at)
  end

end