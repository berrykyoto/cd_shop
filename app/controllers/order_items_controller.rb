class OrderItemsController < ApplicationController
def new
	@order_item = OrderItem.new
	@cart_items = CartItem.all
	@order = Order.all
	# 前ページでクリエイトした送付先情報などを取得（カレントユーザーに紐づいたorders（複数）のうち最後（最新）のorder）

	@total_price = 0
		@cart_items.each do |cart_item|
			@total_price = @total_price + cart_item.item.price * cart_item.quantity
	end
end

def create
	@order_item = OrderItem.new(order_item_params)
	@cart_items = CartItem.all
	@order = Order.all

	@total_price = 0
		@cart_items.each do |cart_item|
			@total_price = @total_price + cart_item.item.price * cart_item.quantity
		end
	if @order_item.save
		flash[:notice] = '注文が完了しました'
        redirect_to root_path# トップページに遷移
    else
    	render :new
    end
end

private
  	def order_item_params
      	params.require(:order_item).permit(:item_id, :quantity, :send_address, :sub_price, :order_id)
  	end

end