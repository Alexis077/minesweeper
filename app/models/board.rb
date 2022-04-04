class Board < ApplicationRecord
    has_one :game_state
    has_many :cells
    has_many :empty_cells, class_name: "Cell"
    has_many :mines, class_name: "Cell"
    has_many :number_cells, class_name: "Cell"
end
