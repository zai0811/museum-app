class AddLatLongToMuseum < ActiveRecord::Migration[7.1]
  def change
    add_column :museums, :latitute, :float
    add_column :museums, :longitude, :float
  end
end
