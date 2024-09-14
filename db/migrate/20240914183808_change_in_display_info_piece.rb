class ChangeInDisplayInfoPiece < ActiveRecord::Migration[7.1]
  def change
    change_column :pieces, :in_display_info, :text
  end
end
