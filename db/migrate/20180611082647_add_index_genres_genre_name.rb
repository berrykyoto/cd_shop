class AddIndexGenresGenreName < ActiveRecord::Migration[5.1]
  def change
  	add_index :genres, :genre_name
  end
end
