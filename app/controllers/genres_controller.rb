class GenresController < ApplicationController

	def index
		@genres = Genre.all
		@genre = Genre.new
		@genrez = Genre.find(params[:id])
	end

	def new
		@genre = Genre.new
	end

	def create
		@genre = Genre.new(genre_params)
		@genre.save
		redirect_to genres_path
	end

	def edit
		@genre = Genre.find(params[:id])
	end

	def update
		@genre = Genre.find(params[:id])
		@genre.update
		redirect_to genres_path
	end

private
  	def genre_params
      	params.require(:genre).permit(:genre_name)
  	end
end
