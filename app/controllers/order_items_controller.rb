class OrderItemsController < ApplicationController
def new
	@order_item = OrderItem.new
	@cart_items = current_user.CartItem.all.includes(:item)
	@orders = Order.all
	@order = current_user.@orders.last
	# 前ページでクリエイトした送付先情報などを取得（カレントユーザーに紐づいたorders（複数）のうち最後（最新）のorder）

	@total_price = 0
		@cart_items.each do |cart_item|
			@total_price = @total_price + cart_item.item.price * cart_item.quantity
	end
end

def create
	@order_item = OrderItem.new(order_item_params)
	if @order_item.save
		flash[:notice] = '注文が完了しました'
        redirect_to items_path　# トップページに遷移
    else
    	render :new
    end
end

end