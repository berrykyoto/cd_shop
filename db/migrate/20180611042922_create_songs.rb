class CreateSongs < ActiveRecord::Migration[5.1]
  def change
    create_table :songs do |t|
		t.string :song_name, :null => false
    	t.string :song_time, :null => false
    	t.integer :song_number, :null => false
    	t.integer :record_id, :null => false
      t.timestamps
    end
  end
end
