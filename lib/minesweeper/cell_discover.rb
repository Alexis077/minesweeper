module Minesweeper
    class CellDiscover
        attr_accessor :board

        def initialize(board)
            @board = board
        end

        def discover_cell_position(y, x)
            raise StandardError.new, :invalid_position if y.negative? || x.negative? || board[y].nil? || board[y][x].nil? 
            cell = board[y][x]
            return cell if cell.flagged? && cell.visible? 
            discover_cell(y, x)
            discover_sorrounding_cells(y, x) unless cell.is_a?(NumberCell) || cell.is_a?(Mine)
            cell
        end

        def discover_all_mines
            board.each_with_index do |row, y|
                row.each_with_index do |cell, x|
                    discover_cell(y, x) if cell.is_a?(Mine)
                end
            end
        end
    
        private

        def discover_sorrounding_cells(y, x)
            
            (-1..1).each do |i|
                (-1..1).each do |j|
                    next if (y + i).negative? || (x + j).negative?
                    next if board[y + i].nil?
                    next if board[y + i][x + j].nil?
                    next if !board[y + i][x + j].hidden?
                
                    if board[y + i][x + j].is_a?(EmptyCell) 
                        discover_cell(y + i, x + j)
                        discover_sorrounding_cells(y + i, x + j)
                    elsif board[y + i][x + j].is_a?(NumberCell)
                        discover_cell(y + i, x + j)
                    end 
                end
            end
        end

        def discover_cell(y, x)
            board[y][x].state = :visible
        end
    end
end