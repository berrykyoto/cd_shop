class OrdersController < ApplicationController
	def index
		@orders = Order.all.includes(:user)
		@order_items = OrderItem.all
		# オーダーアイテムを全件取得
		@first_item = @order_items.first
		# オーダーアイテム（複数）のうち、先頭の商品名を取得

		@total_price = 0
			@order_items.each do |order_item|
				@total_price = @total_price + order_item.sub_price
		# オーダーの合計金額（sub_priceの合計）を計算する。
		end
	end

	def show
		@order = Order.find(params[:id])
		@order_items = OrderItem.all
		# 各オーダーごとのオーダーアイテムを全件取得

		@total_price = 0
			@order_items.each do |order_item|
				@total_price = @total_price + order_item.sub_price
		# オーダーの合計金額（sub_priceの合計）を計算する。
		end
	end

	def new
		@order = Order.new
		@user = current_user
	end

	def create
		@order = Order.new(order_params)
		 @order.save
			flash[:notice] = 'オーダーが保存できたよ(*^-^*)このメッセージは後で消してね'
        	redirect_to new_order_item_path
    	# else
    	# 	render :new
    	# end
	end

	def edit
		@order = Order.find(params[:id])
		@order_items = OrderItem.all
		# 各オーダーごとのオーダーアイテムを全件取得

		@total_price = 0
			@order_items.each do |order_item|
				@total_price = @total_price + order_item.sub_price
		# オーダーの合計金額（sub_priceの合計）を計算する。
		end
	end

	def update
		@order = Order.find(params[:id])
		if order.update(order_params)
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

