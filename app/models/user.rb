class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
has_many :orders
has_many :cart_items
validates :name, presence: true
validates :namekana, presence: true
validates :email, presence: true
validates :post_code, presence: true
validates :address, presence: true
validates :phone, presence: true


def self.search(search)
    if search
      User.where(['name LIKE ?', "%#{search}%"])
    else
      User.all
    end
end


end