module Api
    module V1
        class MineSweeperController < ApplicationController
            def start_game
                GameState.create_game_state(mine_sweeper_params)
                head :ok
            end


            #strong params for mine_sweeper_controller
            def mine_sweeper_params
                params.require(:mine_sweeper).permit(:height, :width, :mines)
            end
        end
    end
end
