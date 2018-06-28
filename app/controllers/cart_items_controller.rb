class CartItemsController < ApplicationController
	before_action :authenticate_user!, except: [:index, :edit, :update]
def index
	if user_signed_in?
		@cart_items = current_user.cart_items.all
		if @cart_items.present?
	    	@total_price = 0
			@cart_items.each do |cart_item|
				@total_price = @total_price + cart_item.item.price * cart_item.quantity
			end
		end
	else
		redirect_to root_path, notice: "無効なURLです。"
	end
end

def create
	@cart_item = CartItem.new(cart_item_params)
	@cart_item.user_id = current_user.id
	@cart_item.save
	redirect_to cart_items_path, notice: "カートに商品が追加されました。"
end

def update
	@cart_item = CartItem.find(params[:id])
	@cart_item.update(cart_item_params)
	redirect_to cart_items_path, notice: "数量が変更されました。"
end

def destroy
	@cart_item = CartItem.find(params[:id])
	@cart_item.destroy
	redirect_to cart_items_path, notice: "削除されました。"
end

def destroy_all
	@cart_items = current_user.cart_items.all
	@cart_items.destroy_all
	redirect_to root_path, notice: "カートを空にしました。"
end

private
def cart_item_params
    params.require(:cart_item).permit(:quantity, :item_id, :user_id)
end


end
