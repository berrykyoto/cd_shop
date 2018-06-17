class UsersController < ApplicationController

	def index
		@users = User.all
		@total_price = 0
		@users.each do |user|
			@total_price = @total_price + user.id * user.id
		end
	end

	def show
		@user = User.find(params[:id])
		@orders = @user.orders.page(params[:page])
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
