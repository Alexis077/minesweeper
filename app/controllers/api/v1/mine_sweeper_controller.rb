module Api
    module V1
        class MineSweeperController < ApplicationController
            before_action :set_game_state, only: [:set_position, :game_board]

            def start_game
                game_state = GameState.create_game_state(mine_sweeper_params)
                render json: {game_state: game_state}
            end

            def game_board
                board_matrix = Minesweeper::GameStateRenderizer.new(@game_state).render_board
                render json: {board: board_matrix, game_state: @game_state}
            end

            private

            def mine_sweeper_params
                params.require(:mine_sweeper).permit(:height, :width, :mines)
            end

            def set_game_state
                @game_state = GameState.find(params[:game_state_id])
            end
        end
    end
end
