class Song < ApplicationRecord
belongs_to :record, inverse_of: :songs
validates :record, presence: true
end
