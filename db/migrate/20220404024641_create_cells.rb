class CreateCells < ActiveRecord::Migration[6.0]
  def change
    create_table :cells do |t|
      t.references :board, null: false, foreign_key: true
      t.integer :x
      t.integer :y
      t.string :state
      t.integer :value
      t.string :type
      t.timestamps
    end
  end
end
