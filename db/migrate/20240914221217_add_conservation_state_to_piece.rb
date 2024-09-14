class AddConservationStateToPiece < ActiveRecord::Migration[7.1]
  def change
    add_column :pieces, :conservation_state, :text
  end
end
