module Api
    module V1
        class MineSweeperController < ApplicationController
            def start_game
                game_state = GameState.create_game_state(mine_sweeper_params)
                board_matrix = Minesweeper::GameStateRenderizer.new(game_state).render_board
                render json: {board: board_matrix, game_state: game_state}
            end


            #strong params for mine_sweeper_controller
            def mine_sweeper_params
                params.require(:mine_sweeper).permit(:height, :width, :mines)
            end
        end
    end
end
