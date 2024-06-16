class CreatePieceCollections < ActiveRecord::Migration[7.1]
  def change
    create_table :piece_collections do |t|
      t.string :name, null: false
      t.integer :status, null: false
      t.references :museum, null: false, foreign_key: true

      t.timestamps
    end
  end
end
