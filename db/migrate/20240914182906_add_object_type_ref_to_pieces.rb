class AddObjectTypeRefToPieces < ActiveRecord::Migration[7.1]
  def change
    add_reference :pieces, :object_type, null: true, foreign_key: true
  end
end
