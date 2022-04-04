class Cell < ApplicationRecord
    belongs_to :board
    enum state: [:hidden, :flagged, :visible]
end
