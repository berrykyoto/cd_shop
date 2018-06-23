class UsersController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show, :edit, :update, :destroy, :user_password_edit]

	def index
		if admin_signed_in?
			@users = User.search(params[:search])
		else
			redirect_to root_path
		end
	end

	def show
		if user_signed_in?
			@user = User.find(params[:id])
			@orders = @user.orders.page(params[:page])
		else admin_signed_in?
			@user = User.find(params[:id])
			@orders = @user.orders.page(params[:page])
		end
	end

	def edit
		if user_signed_in?
			@user = User.find(params[:id])
		else admin_signed_in?
			@user = User.find(params[:id])
		end
	end

	def update
		if user_signed_in?
			@user = User.find(params[:id])
	     	if @user.update(user_params)
	        	redirect_to user_path(@user.id)
	    	else
	      		render :edit
	    	end
	    else admin_signed_in?
	    	@user = User.find(params[:id])
	     	if @user.update(user_params)
	        	redirect_to user_path(@user.id)
	    	else
	      		render :edit
	    	end
	    end
	end

	def destroy
		if user_signed_in?
			user = User.find(params[:id])
	  		user.destroy
	  		redirect_to items_path
	  	else admin_signed_in?
	  		user = User.find(params[:id])
	  		user.destroy
	  		redirect_to items_path
	  	end
  	end

  	def user_password_edit
  		if user_signed_in?
			@user = User.find(params[:id])
		else admin_signed_in?
			@user = User.find(params[:id])
		end
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
