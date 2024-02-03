class CreateRegistrations < ActiveRecord::Migration[7.1]
  def change
    create_table :registrations do |t|
      t.string :manager_email
      t.string :museum_name

      t.timestamps
    end
  end
end
