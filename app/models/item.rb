class Item < ApplicationRecord
belongs_to :admin
belongs_to :genre
has_many :records
accepts_nested_attributes_for :records, allow_destroy: true
has_many :cart_items
has_many :order_items
attachment :item_image
def self.search(search)
    if search
      Item.where(['title LIKE ?', "%#{search}%"])
    else
      Item.all
    end
end

enum style: { single: 0, album: 1 }

end
