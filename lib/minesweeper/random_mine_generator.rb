module Minesweeper
    class RandomMineGenerator
        attr_accessor :number_of_mines, :board
        def initialize(number_of_mines, board)
            @number_of_mines = number_of_mines
            @board = board
        end

        def populate_board
            number_of_mines.times do
                y, x = generate_random_coordinates_until_not_mine
                board[y][x] = Mine.new(y: y, x: x, state: :hidden)
            end
        end

        private

        def generate_random_coordinates
            y = rand(0.. board.length - 1)
            x = rand(0..board[0].length - 1)
            [y, x]
        end

        def generate_random_coordinates_until_not_mine
            y, x = generate_random_coordinates
            while board[y][x].is_a?(Mine)
                y, x = generate_random_coordinates
            end
            [y, x]
        end
    end
end
