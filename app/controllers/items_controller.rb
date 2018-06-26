class ItemsController < ApplicationController

	before_action :authenticate_user!, except: [:index, :show, :new, :create, :edit, :update, :admin_index, :admin_show]

	def index
		@items = Item.search(params[:search])
	end

	def show
		if Item.exists?(id: params[:id])
			@cart_item = CartItem.new
			@item = Item.includes(records: [:songs]).order("songs.song_number").find(params[:id])
			@cart_items = current_user.cart_items.all
			@cart_items.each do |cart_item|
				if  cart_item.item_id == @item.id
					@cart_item = cart_item
					@cart_item.save
				end
			end
	    else
			redirect_to root_path, notice: "無効なURLです。"
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
			redirect_to root_path, notice: "無効URLです。"
		end
	end

	def create
		@admin = current_admin.id
		@item = Item.new(item_params)
		@item.save
		redirect_to admin_index_path, notice: "商品が追加されました。"
	end

	def edit
		if Item.exists?(id: params[:id])
			if admin_signed_in?
				@admin = current_admin.id
				@item = Item.includes(records: [:songs]).find(params[:id])
			else
				redirect_to root_path, notice: "無効なURLです。"
			end
		else
			redirect_to root_path, notice: "無効なURLです。"
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
			redirect_to root_path, notice: "無効なURLです。"
		end
	end

	def admin_show
		if Item.exists?(id: params[:id])
			if admin_signed_in?
				@item = Item.includes(records: [:songs]).order("songs.song_number").find(params[:id])
			else
				redirect_to root_path, notice: "無効なURLです。"
			end
		else
			redirect_to root_path, notice: "無効なURLです。"
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
