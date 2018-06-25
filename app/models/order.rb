class Order < ApplicationRecord
belongs_to :user
has_many :order_items

enum status: { pending: 0, sent: 1, complete: 2}
enum payment: { transfer: 0, credit: 1, cash: 2}

validates :send_name, presence: true, length: { minimum: 2, maximum: 50 }
validates :send_post_code, presence: true, numericality: { only_integer: true }
validates :send_address, presence: true, length: { minimum: 2, maximum: 100 }

end