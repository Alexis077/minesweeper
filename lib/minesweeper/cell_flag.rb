module Minesweeper
    class CellFlag
        attr_accessor :board
    
        def initialize(board)
            @board = board
        end
    
        def flag_cell_position(x, y)
            return board[x][y] if board[x][y].visible? || board[x][y].flagged?
            board[x][y].state = :flagged
        end
    end    
end