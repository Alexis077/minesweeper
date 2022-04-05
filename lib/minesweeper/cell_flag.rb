module Minesweeper
    class CellFlag
        attr_accessor :board
    
        def initialize(board)
            @board = board
        end
    
        def toggle_cell_position(y, x)
            raise StandardError.new, :invalid_position if y.negative? || x.negative? || board[y].nil? || board[y][x].nil? 
            cell = board[y][x]
            return cell if cell.visible?
            if cell.flagged?
                cell.state = :hidden
            else
                cell.state = :flagged
            end 
        end
    end    
end