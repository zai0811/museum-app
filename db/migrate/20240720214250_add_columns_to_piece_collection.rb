class AddColumnsToPieceCollection < ActiveRecord::Migration[7.1]
  def change
    add_column :piece_collections, :is_temporary, :boolean, :default => false
    add_column :piece_collections, :description, :text
  end
end
