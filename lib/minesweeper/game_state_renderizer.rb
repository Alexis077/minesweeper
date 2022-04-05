module Minesweeper
    class GameStateRenderizer
        attr_accessor :cell_matrix
        def initialize(cell_matrix)
            @cell_matrix = cell_matrix
        end
        
        def render_board
            cell_matrix.map! do |row|
                 row.map do  |cell| 

                    next "🟪" if cell.hidden? 
                    next "🚩" if cell.flagged?

                    if cell.is_a?(EmptyCell)
                        "🟩"
                    elsif cell.is_a?(Mine)
                        "💣"
                    elsif cell.is_a?(NumberCell)
                        "#{cell.value}"
                    end
                end                    
            end
        end

        def render_board_without_hidden_cells
            cell_matrix.map! do |row|
                 row.map do  |cell| 

                    if cell.is_a?(EmptyCell)
                        "🟩"
                    elsif cell.is_a?(Mine)
                        "💣"
                    elsif cell.is_a?(NumberCell)
                        "#{cell.value}"
                    end
                end                    
            end
        end
    end
end