class UpdateNilLatLongOnMuseum < ActiveRecord::Migration[7.1]
  def change
    Museum.where(latitude: nil).update_all(latitude: 0.0)
    Museum.where(longitude: nil).update_all(longitude: 0.0)
  end
end
