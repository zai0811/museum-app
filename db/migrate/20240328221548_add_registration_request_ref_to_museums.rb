class AddRegistrationRequestRefToMuseums < ActiveRecord::Migration[7.1]
  def change
    add_reference :museums, :museum_registration_request, null: true, foreign_key: true
  end
end
