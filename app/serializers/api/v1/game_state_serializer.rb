module Api
  module V1
    class GameStateSerializer < ActiveModel::Serializer
      attributes :id, :start_time, :state, :face, :board

      def board
        cell_matrix = Minesweeper::CellMatrixBuilder.new(object).build_cell_matrix
        Minesweeper::GameStateRenderizer.new(cell_matrix).render_board
      end
    end
  end
end