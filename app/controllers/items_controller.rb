class ItemsController < ApplicationController

	before_action :authenticate_user!, except: [:index, :show, :new, :create, :edit, :update, :admin_index, :admin_show]

	def index
		@items = Item.search(params[:search])
	end

	def show
		@cart_item = CartItem.new
		@item = Item.includes(records: [:songs]).order("songs.song_number").find(params[:id])
		@current_item_array = []
    	@item.stock.times do |quantity|
      		if quantity < 10
        		@current_item_array << [quantity + 1, quantity + 1]
      		else
        		break
      		end
    	end
	end

	def new
		if admin_signed_in?
			@admin = current_admin.id
			@item = Item.new
			@record = @item.records.build
			@song = @record.songs.build
			# @item.records.build
			# @item.records.first.songs.build
		else
			redirect_to root_path
		end
	end

	def create
		@admin = current_admin.id
		@item = Item.new(item_params)
		@item.save
		redirect_to admin_index_path
	end

	def edit
		if admin_signed_in?
			@admin = current_admin.id
			@item = Item.includes(records: [:songs]).find(params[:id])
		else
			redirect_to root_path
		end
	end

	def update
		@admin = current_admin.id
		@item = Item.includes(records: [:songs]).find(params[:id])
		@item.update(item_params)
		redirect_to admin_show_path(@item)
	end

	# def destroy
	# 	@item = Item.includes(records: [:songs]).find(params[:id])
	# 	@item.destroy
	# 	redirect_to admin_index_path

	# end

	def admin_index
		if admin_signed_in?
			@items = Item.search(params[:search])
		else
			redirect_to root_path
		end
	end

	def admin_show
		if admin_signed_in?
			@item = Item.includes(records: [:songs]).order("songs.song_number").find(params[:id])
		else
			redirect_to root_path
		end
	end

private
	def item_params
		params.require(:item).permit(
			:id,
			:singer,
			:title,
			:style,
			:item_image,
			:price,
			:label,
			:genre_id,
			:stock,
			:comment,
			:anime,
			:age,
			:admin_id,
			{
				records_attributes: [
					:id,
					:record_name,
					:item_id,
					:_destroy,
					{
						songs_attributes: [
							:id,
							:song_name,
							:song_time,
							:song_number,
							:record_id,
							:_destroy
						]
					}
				]
			}
		)
	end

end
