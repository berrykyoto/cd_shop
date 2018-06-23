class GenresController < ApplicationController
	before_action :authenticate_user!, except: [:index, :new, :create, :edit, :update]

	def index
		if admin_signed_in?
			@genres = Genre.all
			@genre = Genre.new
		else
			redirect_to root_path
		end
	end

	def new
		if admin_signed_in?
			@genre = Genre.new
		else
			redirect_to root_path
		end
	end

	def create
		@genre = Genre.new(genre_params)
		@genre.save
		redirect_to genres_path
	end

	def edit
		if admin_signed_in?
			@genre = Genre.find(params[:id])
		else
			redirect_to root_path
		end
	end

	def update
		@genre = Genre.find(params[:id])
		@genre.update(genre_params)
		redirect_to genres_path
	end
	def destroy
		@genre = Genre.find(params[:id])
		@genre.destroy
		redirect_to genres_path
	end

private
  	def genre_params
      	params.require(:genre).permit(:genre_name)
  	end
end
