class GameState < ApplicationRecord
    belongs_to :board
    enum state: {playing: "playing", resume: "resume", lost: "lost", won: "won"}

    def total_mines
        board.cells.where(type: "Mine").count
    end

    def self.create_game_state(mines, height, width)
        ActiveRecord::Base.transaction do
            raise StandardError.new, :zero_mines if mines.zero?
            raise StandardError.new, :zero_height if height.zero?
            raise StandardError.new, :zero_width if width.zero?
            raise StandardError.new, :invalid_mine_count if mines > height * width
            board = Board.create(height: height, width: width)
            board_matrix = board.get_board_matrix
            Minesweeper::EmptyCellGenerator.new(board_matrix).populate_board
            Minesweeper::RandomMineGenerator.new(mines, board_matrix).populate_board
            Minesweeper::MineNumberGenerator.new(board_matrix).populate_board
            cells = board_matrix.flatten.each{|cell| cell.board = board}
            cells.each { |cell| cell.save! }
            GameState.create(board: board, start_time: Time.now, face: "😀", state: :playing)
        end
    end

    def self.update_game_state(game_state, cell_matrix)
        ActiveRecord::Base.transaction do
            game_rule = Minesweeper::GameRule.new(game_state, cell_matrix)
            Minesweeper::CellDiscover.new(cell_matrix).discover_all_mines if game_rule.game_over?
            game_rule.game_won? if game_rule.game_won?
            game_rule.cell_matrix.flatten.each { |cell| cell.save! if cell.changed? }
            game_rule.game_state.save! if game_rule.game_state.changed?
            game_state
        end
    end
end
