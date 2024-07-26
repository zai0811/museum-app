class AddUserDataToMuseumRegistrationRequest < ActiveRecord::Migration[7.1]
  def change
    add_column :museum_registration_requests, :first_name, :string, :null => false, :default => ""
    add_column :museum_registration_requests, :last_name, :string, :null=> false, :default => ""
    add_column :museum_registration_requests, :ci, :string, :null => false, :default => ""
    add_column :museum_registration_requests, :phone_number, :string
  end
end
