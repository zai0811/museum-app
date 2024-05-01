class CreatePieces < ActiveRecord::Migration[7.1]
  def change
    create_table :pieces do |t|
      t.integer :number
      t.text :description
      t.string :material
      t.string :measurement
      t.integer :conservation_state
      t.integer :status
      t.references :piece_collection, null: false, foreign_key: true

      t.timestamps
    end
  end
end
