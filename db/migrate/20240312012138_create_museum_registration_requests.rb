class CreateMuseumRegistrationRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :museum_registration_requests do |t|
      t.string :museum_name, null: false
      t.string :museum_code, null: false
      t.string :museum_address, null: false
      t.string :manager_email, null: false
      t.integer :registration_status, null: false
      t.timestamps
    end
  end
end
