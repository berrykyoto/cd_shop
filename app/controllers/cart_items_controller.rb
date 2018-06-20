class CartItemsController < ApplicationController
def index
	@cart_items = CartItem.all
	if @cart_items.present?
		@cart_item_array = []
		@cart_items.each do |cart_item|
    	cart_item.item.stock.times do |quantity|
      		if quantity < 10
        		@cart_item_array << [quantity + 1, quantity + 1]
      		else
        		break
      		end
      	end
        end
    	@total_price = 0
		@cart_items.each do |cart_item|
			@total_price = @total_price + cart_item.item.price * cart_item.quantity
		end
	end
end

def create
	@cart_item = CartItem.new(cart_item_params)
	@cart_item.user_id = current_user.id
	@cart_item.save
	redirect_to cart_items_path
end

def edit
	@cart_item = CartItem.find(params[:id])
end

def update
	@cart_item = CartItem.find(params[:id])
	if @cart_item.update(cart_item_params)
		redirect_to cart_items_path, notice: "枚数が変更されました。"
	else
		redirect_to cart_items_path, notice: "在庫が足りません。"
	end
end

def update_quantity
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path
end

def destroy
	@cart_item = CartItem.find(params[:id])
	@cart_item.destroy
	redirect_to cart_items_path
end

private
def cart_item_params
    params.require(:cart_item).permit(:quantity, :item_id, :user_id)
end


end
