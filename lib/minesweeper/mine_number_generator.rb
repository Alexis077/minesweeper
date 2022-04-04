module Minesweeper
    class MineNumberGenerator
        attr_accessor :board

        def initialize(board)
            @board = board
        end

        def populate_board
            board.each_with_index do |row, x|
                row.each_with_index do |cell, y|
                    if board[x][y].is_a?(EmptyCell)
                        mine_amount = count_mines_around_cell(x, y)
                        board[x][y] = NumberCell.new(x: x, y: y, state: :hidden, value: mine_amount) if mine_amount != 0
                    end
                end
            end
        end

        private

        def count_mines_around_cell(x, y)
            mine_amount = 0
            (-1..1).each do |i|
                (-1..1).each do |j|
                    next if (x + i).negative? || (y + j).negative? 
                    if !board[x + i].nil? && board[x + i][y + j].is_a?(Mine)
                        mine_amount += 1 
                    end
                end
            end
            mine_amount
        end    
    end
end