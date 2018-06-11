class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
    	t.integer :admin_id, :null => false
    	t.string :singer, :null => false
    	t.string :title, :null => false
    	t.integer :style, :null => false, :default => "0"
    	t.text :item_image_id, :null => false
        t.integer :price, :null => false
    	t.string :label, :null => false
    	t.integer :genre_id, :null => false
    	t.string :stock, :null => false
    	t.text :comment, :null => false
    	t.string :anime, :null => false
    	t.string :age, :null => false
      t.timestamps
    end
  end
end
