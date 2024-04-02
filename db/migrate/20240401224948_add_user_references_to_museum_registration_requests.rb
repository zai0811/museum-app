class AddUserReferencesToMuseumRegistrationRequests < ActiveRecord::Migration[7.1]
  def change
    add_reference :museum_registration_requests, :created_by, null: true, foreign_key: { to_table: :users}
    add_reference :museum_registration_requests, :updated_by, null: true, foreign_key: { to_table: :users}
  end
end
