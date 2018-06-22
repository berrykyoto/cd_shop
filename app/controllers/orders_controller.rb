class OrdersController < ApplicationController
	before_action :authenticate_user!
	def index
		@orders = Order.all.includes(:user)
	end

	def show
		@order = Order.find(params[:id])
	end

	def new
		@order = Order.new
		@user = current_user
	end

	def create
		@order = Order.new(order_params)
		 @order.save
        	redirect_to new_order_item_path
	end

	def edit
		@order = Order.find(params[:id])
	end

	def update
		@order = Order.find(params[:id])
		if @order.update(order_params)
       		redirect_to orders_path
    	else
     		render :edit
    	end
	end

	def destroy
		order = Order.find(params[:id])
  		order.destroy
  		redirect_to orders_path
  	end

private
  	def order_params
      	params.require(:order).permit(:send_name, :send_post_code, :send_address, :payment, :user_id)
  	end

end

