class GameState < ApplicationRecord
    belongs_to :board
    enum state: {playing: "playing", resume: "resume", lost: "lost", won: "won"}

    def total_mines
        board.mines.count
    end

    def self.create_game_state(mine_sweeper_params)
        ActiveRecord::Base.transaction do
            board = Board.create(height: mine_sweeper_params[:height], width: mine_sweeper_params[:width])
            board_matrix = board.get_board_matrix
            Minesweeper::EmptyCellGenerator.new(board_matrix).populate_board
            Minesweeper::RandomMineGenerator.new(mine_sweeper_params[:mines], board_matrix).populate_board
            Minesweeper::MineNumberGenerator.new(board_matrix).populate_board
            cells = board_matrix.flatten.each{|cell| cell.board = board}
            cells.each { |cell| cell.save! }
            GameState.create(board: board, start_time: Time.now, face: "😀", state: :playing)
        end
    end

    def self.update_game_state(game_state, cell_matrix)
        ActiveRecord::Base.transaction do
            board_matrix.flatten.each { |cell| cell.save! }
        end
    end
end