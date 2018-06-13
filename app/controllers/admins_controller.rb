class AdminsController < ApplicationController

	def show
		@admin = Admin.find(params[:id])
	end

	def edit
		@admin = Admin.find(params[:id])
	end

	def update
		@admin = Admin.find(params[:id])
      	if @admin.update(admin_params)
      		redirect_to admin_path(@admin)
      	else
      		render :edit
      	end
	end

private
  	def user_params
      	params.require(:admin).permit(:name, :email, :password)
  	end

end
