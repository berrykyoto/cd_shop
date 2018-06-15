class OrderItemsController < ApplicationController
def new
	@order_item = OrderItem.new
	@ = CartItem.all
end

def create
	@order_item = OrderItem.new(order_item_params)
end

end