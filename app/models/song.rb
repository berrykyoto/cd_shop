class Song < ApplicationRecord
belongs_to :record
# validates :record, presence: true
validates :song_name, presence: true
validates :song_time, presence: true
validates :song_number, presence: true


end
