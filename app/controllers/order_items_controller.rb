class OrderItemsController < ApplicationController
def new
	@order_item = OrderItem.new
	@cart_items = current_user.cart_items.all.includes(:item)
	@order = Order.find(params[:id])

	@total_price = 0
		@cart_items.each do |cart_item|
			@total_price = @total_price + cart_item.item.price * cart_item.quantity
	end
end

def create
	@order_item = OrderItem.new(order_item_params)
end

end