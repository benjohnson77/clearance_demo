class StylesController < ApplicationController
	#ParentsController
	def create	
  	@style = Style.create style_params
    render :index
  end

  def index
    @style = Style.find(params[:style_id])  
    @style_types = Style.group(:type).collect(&:type)
    @items = Item.where(style_id: params[:style_id]).order(:status) 
    @item = Item.new   
  end	

  def update
    @style = Style.find(params[:id])

		if @style.update style_params
	  	flash[:notice] = "Successfully updated product."  
	 	end  
	 	redirect_to styles_path(style_id: @style.id, item_id: params[:item_id]) 
  end

  private

  def style_params
  	params.require(:style).permit(:name, :wholesale_price, :retail_price, :type)
	end

end
