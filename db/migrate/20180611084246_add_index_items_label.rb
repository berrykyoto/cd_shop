class AddIndexItemsLabel < ActiveRecord::Migration[5.1]
  def change
  	add_index :items, [:label, :anime, :age]
  end
end
