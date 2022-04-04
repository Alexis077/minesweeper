module Minesweeper
    class GameStateRenderizer
        attr_accessor :game_state
        def initialize(game_state)
            @game_state = game_state
        end
        
        def render_board
            build_cell_matrix.map! do |row|
                 row.map do  |cell| 
                    next "#" if cell.state == :hidden 
                    next "F" if cell.state == :flagged 

                    if cell.is_a?(EmptyCell)
                        "."
                    elsif cell.is_a?(Mine)
                        "*"
                    elsif cell.is_a?(NumberCell)
                        "#{cell.value}"
                    end
                end                    
            end
        end

        private

        def build_cell_matrix
            board_matrix = game_state.board.get_board_matrix
            game_state.board.cells.each do |cell|
                board_matrix[cell.x][cell.y] = cell
            end
            board_matrix
        end
    end
end