module Api
    module V1
        class MineSweeperController < ApplicationController
            before_action :set_game_state, only: [:set_position, :toggle_flag, :game_board]
            before_action :build_cell_matrix, only: [:set_position, :toggle_flag, :game_board]
            before_action :validate_game_state, only: [:set_position, :toggle_flag]
            
            def start_game
                render json: GameState.create_game_state(mine_sweeper_params)
            rescue StandardError => e
                render json: {error: e.message}, status: :bad_request
            end

            def set_position 
                Minesweeper::CellDiscover.new(@cell_matrix).discover_cell_position(position_params[:y], position_params[:x])
                render json: GameState.update_game_state(@game_state, @cell_matrix)
            rescue StandardError => e
                render json: {error: e.message}, status: :bad_request
            end

            def toggle_flag
                Minesweeper::CellFlag.new(@cell_matrix).toggle_cell_position(position_params[:y], position_params[:x])
                render json: GameState.update_game_state(@game_state, @cell_matrix)
            end
            
            def game_board
                render json: @game_state
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
            rescue ActiveRecord::RecordNotFound => e
                render json: {error: e.message}, status: :bad_request
            end

            def build_cell_matrix
                @cell_matrix = Minesweeper::CellMatrixBuilder.new(@game_state).build_cell_matrix
            end

            def validate_game_state
                return render json: {error: "Game over. You lost.", state: :lost}, status: :ok if @game_state.lost?
                return render json: {error: "Game over. You won.", state: :won}, status: :ok if @game_state.won?
                return render json: {error: "You can't play.", state: :resume}, status: :ok if @game_state.resume?
            end
        end
    end
end
