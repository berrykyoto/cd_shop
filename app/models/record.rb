class Record < ApplicationRecord
belongs_to :item, inverse_of: :records
has_many :songs, inverse_of: :records
accepts_nested_attributes_for :songs, allow_destroy: true

validates :item, presence: true

end
