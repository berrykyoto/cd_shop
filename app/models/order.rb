class Order < ApplicationRecord
belongs_to :user
has_many :order_items

def sum_of_price
	price * quantity
end

end
