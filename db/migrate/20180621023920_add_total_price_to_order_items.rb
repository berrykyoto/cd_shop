class AddTotalPriceToOrderItems < ActiveRecord::Migration[5.1]
  def change
    add_column :order_items, :total_price, :integer
  end
end
