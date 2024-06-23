class RenameMuseumMuseumStatusToStatus < ActiveRecord::Migration[7.1]
  def change
    rename_column :museums, :museum_status, :status
  end
end
