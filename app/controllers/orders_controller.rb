class OrdersController < ApplicationController
	def index
		@orders = Order.all
	end

	def show
		@order = Order.find(params[:id])
		@order_items = @order.order_items.all
		@item = Item.find(params[:id])
	end

	def new
		@order = Order.new
	end

	def create
		@order = Order.new(order_params)
		if @order.save
			flash[:notice] = 'オーダーが保存できたよ(*^-^*)このメッセージは後で消してね'
        	redirect_to new_order_item_path(order)
    	else
    		render :new
    	end
	end

	def edit
		@order = Order.find(params[:id])
		@order_items = @order.order_items.all
		@item = Item.find(params[:id])
	end

	def update
		@order = Order.find(params[:id])
    	if @order.update(order_params)
       		redirect_to orders_path
    	else
     		render :edit
    	end
	end

private
  	def order_params
      	params.require(:order).permit(:send_name, :send_post_code, :send_address, :payment, :user_id)
  	end

end

