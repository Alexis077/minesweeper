module Api
  module V1
    class GameStateSerializer < ActiveModel::Serializer
      attributes :id, :board_id, :start_time, :state, :total_mines, :created_at, :updated_at
    end
  end
end