module Minesweeper
    class CellFlag
        attr_accessor :board
    
        def initialize(board)
            @board = board
        end
    
        def toggle_cell_position(x, y)
            raise StandardError.new, :invalid_position if x.negative? || y.negative? || board[x].nil? || board[x][y].nil? 
            return board[x][y] if board[x][y].visible?
            if board[x][y].flagged?
                board[x][y].state = :hidden
            else
                board[x][y].state = :flagged
            end 
        end
    end    
end