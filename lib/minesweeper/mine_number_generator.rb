module Minesweeper
    class MineNumberGenerator
        attr_accessor :board

        def initialize(board)
            @board = board
        end

        def populate_board
            board.each_with_index do |row, y|
                row.each_with_index do |cell, x|
                    if board[y][x].is_a?(EmptyCell)
                        mine_amount = count_mines_around_cell(y, x)
                        board[y][x] = NumberCell.new(y: y, x: x, state: :hidden, value: mine_amount) if mine_amount != 0
                    end
                end
            end
        end

        private

        def count_mines_around_cell(y, x)
            mine_amount = 0
            (-1..1).each do |i|
                (-1..1).each do |j|
                    next if (y + i).negative? || (x + j).negative? 
                    if !board[y + i].nil? && board[y + i][x + j].is_a?(Mine)
                        mine_amount += 1 
                    end
                end
            end
            mine_amount
        end    
    end
end