class OrderItemsController < ApplicationController
	before_action :authenticate_user!
def new
	@order_item = OrderItem.new
	@cart_items = CartItem.all
	@orders = Order.all
	# 前ページでクリエイトした送付先情報などを取得（カレントユーザーに紐づいたorders（複数）のうち最後（最新）のorder）

	@total_price = 0
		@cart_items.each do |cart_item|
			@total_price = @total_price + cart_item.item.price * cart_item.quantity
	end
end

def create
	@cart_items = CartItem.all
	@orders = Order.all

	@total_price = 0
		@cart_items.each do |cart_item|
			@order_item = OrderItem.new(order_item_params)
			@order_item.item_id = cart_item.item_id
			@order_item.quantity = cart_item.quantity
			@order_item.sub_price = cart_item.item.price * cart_item.quantity
			@total_price = @total_price + @order_item.sub_price
			@order_item.total_price = @total_price
			@order_item.save
		end

		CartItem.destroy_all
        redirect_to root_path# トップページに遷移
        flash[:notice] = '注文が完了しました'

end

private
  	def order_item_params
      	params.require(:order_item).permit(:item_id, :quantity, :sub_price, :total_price, :order_id)
  	end

end