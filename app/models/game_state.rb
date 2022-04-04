class GameState < ApplicationRecord
    belongs_to :board
    enum state: [:playing,:resume, :lost, :won]

    def self.create_game_state(mine_sweeper_params)
        ActiveRecord::Base.transaction do
            board = Board.create(height: mine_sweeper_params[:height], width: mine_sweeper_params[:width])
            board_matrix = board.get_board_matrix
            Minesweeper::EmptyCellGenerator.new(board_matrix).populate_board
            Minesweeper::RandomMineGenerator.new(mine_sweeper_params[:mines], board_matrix).populate_board
            Minesweeper::MineNumberGenerator.new(board_matrix).populate_board
            board_matrix.flatten.each(&:save)
            GameState.create(board: board, start_time: Time.now, face: "😀", state: "playing")
        end
    end
end
