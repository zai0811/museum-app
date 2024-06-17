class AddMaterialRefToPieces < ActiveRecord::Migration[7.1]
  def change
    add_reference :pieces, :material, null: false, foreign_key: true
  end
end
