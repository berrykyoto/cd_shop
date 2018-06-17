class Item < ApplicationRecord
belongs_to :admin
belongs_to :genre
has_many :records, inverse_of: :Item
accepts_nested_attributes_for :records, allow_destroy: true
has_many :cart_items
has_many :order_items
def self.search(search) 
    if search 
      Item.where(['title LIKE ?', "%#{search}%"])
    else
      Item.all
    end
  end
end
