module Api
    module V1
        class MineSweeperController < ApplicationController
            def start_game
                head :ok
            end
        end
    end
end
