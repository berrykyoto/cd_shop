class OrdersController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show, :edit, :update]
	def index
		if admin_signed_in?
			@orders = Order.all.includes(:user)
		else
			redirect_to root_path, notice: "無効なURLです。"
		end
	end

	def show
		if admin_signed_in?
			@order = Order.find(params[:id])
		else
			@order = Order.find(params[:id])
		end
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
		if admin_signed_in?
			@order = Order.find(params[:id])
		else
			redirect_to root_path, notice: "無効なURLです。"
		end
	end

	def update
		@order = Order.find(params[:id])
		@order.update(order_params)
		if admin_signed_in?
       		redirect_to orders_path
       	else user_signed_in?
       		redirect_to new_order_item_path
       	end
	end

	def user_order_edit
	    if user_signed_in?
	    	@user = current_user
	     	@order = Order.find(params[:id])
	     	@order.save
	    else
	     	redirect_to root_path, notice: "無効なURLです。"
	    end
    end

	def destroy
		order = Order.find(params[:id])
  		order.destroy
  		redirect_to cart_items_path
  	end


private
  	def order_params
      	params.require(:order).permit(:send_name, :send_post_code, :send_address, :payment, :user_id, :status)
  	end

end

