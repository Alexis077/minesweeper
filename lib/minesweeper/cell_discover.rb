module Minesweeper
    class CellDiscover
        attr_accessor :board

        def initialize(board)
            @board = board
        end

        def discover_cell_position(x, y)
            return board[x][y] if board[x][y].flagged? && board[x][y].visible? 
            discover_cell(x, y)
            discover_sorrounding_cells(x, y) unless board[x][y].is_a?(NumberCell) || board[x][y].is_a?(Mine)
            board[x][y]
        end

        def discover_all_mines
            board.each_with_index do |row, x|
                row.each_with_index do |cell, y|
                    discover_cell(x, y) if cell.is_a?(Mine)
                end
            end
        end
    
        private

        def discover_sorrounding_cells(x, y)
            (-1..1).each do |i|
                (-1..1).each do |j|
                    next if (x + i).negative? || (y + j).negative? 
                    next if board[x + i].nil?
                    next if board[x + i][y + j].nil?
                    next if board[x + i][y + j].state != :hidden
                    
                    if board[x + i][y + j].is_a?(EmptyCell) 
                        discover_cell(x + i, y + j)
                        discover_sorrounding_cells(x + i, y + j)
                    elsif board[x + i][y + j].is_a?(NumberCell)
                        discover_cell(x + i, y + j)
                    end 
                end
            end
        end

        def discover_cell(x, y)
            board[x][y].state = :visible
        end
    end
end