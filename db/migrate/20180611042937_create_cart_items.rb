class CreateCartItems < ActiveRecord::Migration[5.1]
  def change
    create_table :cart_items do |t|
    	t.integer :user_id, :null => false
    	t.integer :item_id, :null => false
    	t.integer :quantity, :null => false
      t.timestamps
    end
  end
end
