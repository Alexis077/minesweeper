module Minesweeper
    class EmptyCellGenerator 
        attr_accessor :board
    
        def initialize(board)
            @board = board
        end
    
        def populate_board
            board.each_with_index do |row, y|
                row.each_with_index do |cell, x|
                    board[y][x] = EmptyCell.new(y: y, x: x, state: :hidden)
                end
            end
        end
    end
end

