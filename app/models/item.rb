class Item < ApplicationRecord
belongs_to :admin
belongs_to :genre
has_many :records
has_many :cart_items
has_many :order_items
end
