module Minesweeper
    class RandomMineGenerator
        attr_accessor :number_of_mines, :board
        def initialize(number_of_mines, board)
            @number_of_mines = number_of_mines
            @board = board
        end

        def populate_board
            number_of_mines.times do
                x, y = generate_random_coordinates_until_not_mine
                board[x][y] = Mine.new(x, y, :hidden)
            end
        end

        private

        def generate_random_coordinates
            x = rand(0..board[0].length - 1)
            y = rand(0.. board.length - 1)
            [x, y]
        end

        def generate_random_coordinates_until_not_mine
            x, y = generate_random_coordinates
            while board[x][y].is_a?(Mine)
                x, y = generate_random_coordinates
            end
            [x, y]
        end
    end
end
