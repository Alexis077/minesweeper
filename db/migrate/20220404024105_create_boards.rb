class CreateBoards < ActiveRecord::Migration[6.0]
  def change
    create_table :boards do |t|
      t.integer :height, default: 0
      t.integer :width, default: 0
      t.timestamps
    end
  end
end
