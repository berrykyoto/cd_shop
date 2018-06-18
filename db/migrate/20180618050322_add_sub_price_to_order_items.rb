class AddSubPriceToOrderItems < ActiveRecord::Migration[5.1]
  def change
    add_column :order_items, :sub_price, :integer
  end
end
