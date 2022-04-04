module Minesweeper
    class CellMatrixBuilder
        attr_accessor :game_state
    
        def initialize(game_state)
            @game_state = game_state    
        end
        
        def build_cell_matrix
            board_matrix = game_state.board.get_board_matrix
            game_state.board.cells.each do |cell|
                board_matrix[cell.x][cell.y] = cell
            end
            board_matrix
        end
    end
end
