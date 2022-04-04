module Minesweeper
    class EmptyCellGenerator 
        attr_accessor :board
    
        def initialize(board)
            @board = board
        end
    
        def populate_board
            board.each_with_index do |row, x|
                row.each_with_index do |cell, y|
                    board[x][y] = EmptyCell.new(x: x, y: y, state: :hidden)
                end
            end
        end
    end
end

