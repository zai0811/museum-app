class AddColumnsToPiece < ActiveRecord::Migration[7.1]
  def change
    add_column :pieces, :period, :string
    add_column :pieces, :in_display, :boolean, :default => true
    rename_column :pieces, :conservation_state, :in_display_info
  end
end
