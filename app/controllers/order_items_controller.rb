class OrderItemsController < ApplicationController
def new
	@order_item = OrderItem.new
	@cart_items = current_user.cart_items.all.includes(:item)
	@order = Order.find(params[:id])
end

def create
	@order_item = OrderItem.new(order_item_params)
end

end