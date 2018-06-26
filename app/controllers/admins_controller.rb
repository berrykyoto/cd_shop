class AdminsController < ApplicationController
	before_action :authenticate_user!, except: [:show, :edit, :update, :admin_password_edit]

	def show
		if admin_signed_in?
			@admin = Admin.find(params[:id])
		else
			redirect_to root_path, notice: "無効なURLです。"
		end
	end

	def edit
		if admin_signed_in?
			@admin = Admin.find(params[:id])
		else
			redirect_to root_path, notice: "無効なURLです。"
		end
	end

	def update
		@admin = Admin.find(params[:id])
      	if @admin.update(admin_params)
      		redirect_to admin_path(@admin)
      	else
      		render :edit
      	end
	end

	def admin_password_edit
		if admin_signed_in?
			@admin = Admin.find(params[:id])
		else
			redirect_to root_path, notice: "無効なURLです。"
		end
	end

private
  	def admin_params
      	params.require(:admin).permit(:name, :email, :password)
  	end

end
