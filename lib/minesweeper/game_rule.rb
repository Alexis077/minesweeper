module Minesweeper
    class GameRule
        attr_accessor :game_state, :cell_matrix

        def initialize(game_state, cell_matrix)
            @game_state = game_state
            @cell_matrix = cell_matrix
        end
        
        def game_over?
            has_visible_mines = cell_matrix.flatten.any? { |cell| cell.is_a?(Mine) && cell.visible? }
            if has_visible_mines
                game_state.face = "😵"
                game_state.state = :lost
                return true
            else
                return false
            end
        end

        def game_won?
            flagged_cells = cell_matrix.flatten.count { |cell| cell.flagged? }
            flagged_mines = cell_matrix.flatten.count { |cell| cell.is_a?(Mine) && cell.flagged? }
            if flagged_cells == game_state.total_mines && flagged_mines == game_state.total_mines
                game_state.face = "😎"
                game_state.state = :won
                return true
            else
                return false
            end
        end
    end
end