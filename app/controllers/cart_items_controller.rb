class CartItemsController < ApplicationController
def index
	@cart_items = CartItem.all
	@cart_item = CartItem.find(params[:id])
	@current_cart_item_array = []
    @cart_item.stock.times do |quantity|
      if quantity < 10
        @current_cart_item_array << [quantity + 1, quantity + 1]
      else
        break
      end
    end
    @total_price = 0
	@cart_items.each do |cart_item|
		@total_price = @total_price + cart_item.item.price * cart_item.quantity
	end
end

def create
	@cart_item = Cart_item.new(cart_item_params)
	@cart_item.user_id = current_user.id
	@item = Item.find(params[:item_id])
	@cart_item.save
	redirect_to cart_items_path
end

def edit
	@cart_item = Cart_item.find(params[:id])
end

def update
	@cart_item = Cart_item.find(params[:id])
	@cart_item.update(cart_item_params)
	redirect_to cart_items_path
end

def update_quantity
    @cart_item = Cart_item.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path
end

def destroy
	@cart_item = Cart_item.find(params[:id])
	@cart_item.destroy
	redirect_to cart_items_path
end

private
def cart_item_params
    params.require(:cart_item).permit(:quantity, :item_id, :user_id)
end


end
