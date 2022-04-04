class CreateGameStates < ActiveRecord::Migration[6.0]
  def change
    create_table :game_states do |t|
      t.references :board, null: false, foreign_key: true
      t.datetime :start_time
      t.string :face
      t.string :state
      t.timestamps
    end
  end
end
