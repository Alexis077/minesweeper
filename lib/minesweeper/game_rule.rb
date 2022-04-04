class GameRule
    attr_accessor :game_state

    def initialize(game_state)
        @game_state = game_state
    end
    
    def game_over?
        has_visible_mines = game_state.board.flatten.any? { |cell| cell.is_a?(Mine) && cell.visible? }
        if has_visible_mines
            game_state.face = "😵"
            game_state.state = :lost
            CellDiscover.new(game_state.board).discover_all_mines
            return true
        else
            return false
        end
    end

    def game_won?
        flagged_cells = game_state.board.flatten.count { |cell| cell.flagged? }
        flagged_mines = game_state.board.flatten.count { |cell| cell.is_a?(Mine) && cell.flagged? }
        if flagged_cells == game_state.total_mines && flagged_mines == game_state.total_mines
            game_state.face = "😎"
            game_state.state = :won
            return true
        else
            return false
        end
    end
end