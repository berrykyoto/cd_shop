class UsersController < ApplicationController
	before_action :authenticate_user!, except: [:index]

	def index
		if admin_signed_in?
		@users = User.search(params[:search])
		else
			redirect_to root_path
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
  		redirect_to items_path
  	end

private
	def correct_user
		@admin = Admin.find(params[:id])
		redirect_to(root_path) unless @admin == current_user
	end
  	def user_params
      	params.require(:user).permit(:name, :name_kana, :email, :post_code, :address, :phone, :password)
  	end
end
