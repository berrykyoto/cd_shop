class AddIndexSongsSongName < ActiveRecord::Migration[5.1]
  def change
  	add_index :songs, :song_name
  end
end
