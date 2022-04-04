module Minesweeper
    class GameStateRenderizer
        attr_accessor :cell_matrix
        def initialize(cell_matrix)
            @cell_matrix = cell_matrix
        end
        
        def render_board
            cell_matrix.map! do |row|
                 row.map do  |cell| 
                    next "#" if cell.hidden? 
                    next "F" if cell.flagged? 

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
    end
end