class Record < ApplicationRecord
belongs_to :item
has_many :songs
accepts_nested_attributes_for :songs, allow_destroy: true

validates :record_name, presence: true

# validates :item, presence: true

end