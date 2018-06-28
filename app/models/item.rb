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
      Item.where(['title LIKE :item OR singer LIKE :item OR anime LIKE :item', item: "%#{search}%"])
    else
      Item.all.order(id: "DESC")
    end
end

enum style: { single: 0, album: 1 }

validates :singer, presence: true
validates :title, presence: true
validates :price, presence: true, numericality: { only_integer: true }
validates :label, presence: true
validates :stock, presence: true, numericality: { only_integer: true }
validates :comment, presence: true
validates :anime, presence: true
validates :age, presence: true

end