module Api
    module V1
        class MineSweeperController < ApplicationController
            before_action :set_game_state, only: [:set_position, :game_board]

            def start_game
                game_state = GameState.create_game_state(mine_sweeper_params)
                render json: {game_state: game_state}
            end


            def set_position 
                cell_matrix = Minesweeper::CellMatrixBuilder.new(@game_state).build_cell_matrix
                CellDiscover.new(cell_matrix).discover_cell_position(position_params[:x], position_params[:y])
                GameState.update_game_state(@game_state, cell_matrix)
            end

            def game_board
                cell_matrix = Minesweeper::CellMatrixBuilder.new(@game_state).build_cell_matrix
                board_matrix_with_cells = Minesweeper::GameStateRenderizer.new(cell_matrix).render_board
                render json: {board: board_matrix_with_cells, game_state: @game_state}
            end

            private

            def mine_sweeper_params
                params.require(:mine_sweeper).permit(:height, :width, :mines)
            end

            def position_params
                params.require(:position).permit(:x, :y)
            end

            def set_game_state
                @game_state = GameState.find(params[:game_state_id])
            end
        end
    end
end
