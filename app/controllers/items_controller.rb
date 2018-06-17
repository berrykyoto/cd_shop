class ItemsController < ApplicationController
	def index
		@items = Item.search(params[:search])
	end

	def show
		@item = Item.find(params[:id]).includes(records: [:songs])
		@current_item_array = []
    	@items.current_item.times do |quantity|
      		if quantity < 10
        		@current_item_array << [quantity, quantity]
      		else
        		break
      		end
    	end
	end

	def new
		@item = Item.new
		@item.records.build
		@item.records.first.songs.build
	end

	def create
		@item = Item.new(item_params)
		@item.save
		redirect_to admin_index_path
	end

	def edit
		@item = Item.find(params[:id]).includes(records: [:songs])
	end

	def update
		@item = Item.find(params[:id]).includes(records: [:songs])
		@item.update(item_params)
		redirect_to admin_show_path(item.id)
	end

	def destroy
		@item = Item.find(params[:id]).includes(records: [:songs])
		@item.destroy
		redirect_to admin_index_path

	end

	def admin_index
		@items = Item.search(params[:search])
	end

	def admin_show
		@item = Item.find(params[:id]).includes(records: [:songs])
	end

private
	def item_params
		params.require(:item).permit(
			:id,
			:singer,
			:title,
			:style,
			:item_image_id,
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
