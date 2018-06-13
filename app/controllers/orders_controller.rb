class OrdersController < ApplicationController
	def index
		@orders = Oder.all
	end

	def show
		@order = Order.find(params[:id])
		@order_items = @order.order_items.page(params[:page])
	end

	def new
		@order = Order.new
	end

	def create
		@order = Order.new(order_params)

	end

	def edit
		@order = Order.find(params[:id])
	end

	def update
		@order = Order.find(params[:id])
    	if @order.update(order_params)
       		redirect_to order_path(@order.id)
    	else
     		render :edit
    	end
	end

private
  	def order_params
      	params.require(:order).permit(:send_name, :send_post_code, :send_address, :payment)
  	end

end
