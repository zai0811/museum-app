class AddDefaultValueToLatLong < ActiveRecord::Migration[7.1]
  def change
    change_column_default :museums, :latitude, from: nil, to: 0.0
    change_column_default :museums, :longitude, from: nil, to: 0.0
  end
end
