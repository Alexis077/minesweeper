module Api
  module V1
    class GameStateSerializer < ActiveModel::Serializer
      attributes :id, :start_time, :state, :face
    end
  end
end