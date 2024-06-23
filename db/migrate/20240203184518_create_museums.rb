class CreateMuseums < ActiveRecord::Migration[7.1]
  def change
    create_table :museums do |t|
      t.string :name, null: false
      t.string :code, null: false
      t.text :about
      t.string :email
      t.string :phone
      t.string :page
      t.string :address
      t.integer :museum_status, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
