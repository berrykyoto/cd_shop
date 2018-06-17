class ChangeDatatypeStockOfItems < ActiveRecord::Migration[5.1]
  def change
  	change_column :items, :stock, :integer
  end
end
