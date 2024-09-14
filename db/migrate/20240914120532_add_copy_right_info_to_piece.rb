class AddCopyRightInfoToPiece < ActiveRecord::Migration[7.1]
  def change
    add_column :pieces, :copyright_info, :text
  end
end
