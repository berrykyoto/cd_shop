class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
    	t.integer :user_id, :null => false
    	t.string :send_name, :null => false
    	t.string :send_post_code, :null => false
    	t.string :send_address, :null => false
    	t.integer :payment, :null => false, :default => "0"
    	t.integer :status, :null => false, :default => "0"
      t.timestamps
    end
  end
end
