class UsersController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show, :edit, :update, :destroy, :user_password_edit, :about, :payment, :return, :privacy, :tokutei, :delivery]


	def index
		if admin_signed_in?
			@users = User.search(params[:search])
		else
			redirect_to root_path, notice: "無効なURLです。"
		end
	end

	def show
		if User.exists?(id: params[:id])
			if user_signed_in?
				@user = User.find(params[:id])
				@orders = @user.orders.page(params[:page]).order(id: "DESC")
			elsif admin_signed_in?
				@user = User.find(params[:id])
				@orders = @user.orders.page(params[:page]).order(id: "DESC")
			else
				redirect_to root_path
			end
		else
			redirect_to root_path, notice: "無効なURLです。"
		end
	end

	def edit
		if User.exists?(id: params[:id])
			if user_signed_in?
				@user = User.find(params[:id])
			elsif admin_signed_in?
				@user = User.find(params[:id])
			else
				redirect_to root_path, notice: "無効なURLです。"
			end
		else
			redirect_to root_path, notice: "無効なURLです。"
		end
	end

	def update
		if user_signed_in?
			@user = User.find(params[:id])
	     	if @user.update(user_params)
	        	redirect_to user_path(@user.id), notice: "更新できました。"
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
	  		redirect_to root_path, notice: "退会しました。"
	  	else admin_signed_in?
	  		user = User.find(params[:id])
	  		user.destroy
	  		redirect_to users_path
	  	end
  	end

  	def user_password_edit
  		if User.exists?(id: params[:id])
	  		if user_signed_in?
				@user = User.find(params[:id])
			elsif admin_signed_in?
				@user = User.find(params[:id])
			else
				redirect_to root_path, notice: "無効なURLです。"
			end
		else
			redirect_to root_path, notice: "無効なURLです。"
		end
  	end

private
  	def user_params
      	params.require(:user).permit(:name, :name_kana, :email, :post_code, :address, :phone, :password)
  	end
end
