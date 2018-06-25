class Contact < ApplicationRecord
	validates :name, presence: true, length: { minimum: 2, maximum: 50 }
	validates :email, presence: true
	validates :title, presence: true
	validates :body, presence: true
end

