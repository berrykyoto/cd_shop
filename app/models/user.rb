class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
has_many :orders, :dependent => :delete_all
has_many :cart_items

validates :name, presence: true, length: { minimum: 2, maximum: 50 }
validates :name_kana, presence: true, length: { minimum: 2, maximum: 50 }
validates :email, presence: true
validates :post_code, presence: true, numericality: { only_integer: true }
validates :address, presence: true, length: { minimum: 2, maximum: 100 }
validates :phone, presence: true, numericality: { only_integer: true }


def self.search(search)
    if search
      User.where(['name LIKE :user OR phone LIKE :user OR address LIKE :user', user: "%#{search}%"])
    else
      User.all
    end
end


end
