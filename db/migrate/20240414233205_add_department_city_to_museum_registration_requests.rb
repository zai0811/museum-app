class AddDepartmentCityToMuseumRegistrationRequests < ActiveRecord::Migration[7.1]
  def change
    add_reference :museum_registration_requests, :department, null: false, foreign_key: true
    add_reference :museum_registration_requests, :city, null: false, foreign_key: true
  end
end
