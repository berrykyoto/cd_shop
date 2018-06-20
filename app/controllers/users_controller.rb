class UsersController < ApplicationController

	def index
		@users = User.search(params[:search])
	end

	def show
		@user = User.find(params[:id])
		@orders = @user.orders.page(params[:page])
		if @orders.present?
			@order_item = @order.order_item.first # order_itemの最初のレコード取得
			@order_items = @order.order_item.all
			@total_price = @order_items.sum(:sub_price) # 合計処理
		end
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
     	if @user.update(user_params)
        	redirect_to user_path(@user.id)
    	else
      		render :edit
    	end
	end

	def destroy
		user = User.find(params[:id])
  		user.destroy
  		redirect_to items_path #redirect先変える
  	end

private
  	def user_params
      	params.require(:user).permit(:name, :name_kana, :email, :post_code, :address, :phone, :password)
  	end
end
