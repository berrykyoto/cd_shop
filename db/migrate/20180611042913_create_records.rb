class CreateRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :records do |t|
    	t.string :record_name, :null => false
    	t.integer :item_id, :null => false
      t.timestamps
    end
  end
end
