class AddDepartmentCityToMuseums < ActiveRecord::Migration[7.1]
  def change
    add_reference :museums, :department, null: false, foreign_key: true
    add_reference :museums, :city, null: false, foreign_key: true
  end
end
