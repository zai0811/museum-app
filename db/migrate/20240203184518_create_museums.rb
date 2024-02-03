class CreateMuseums < ActiveRecord::Migration[7.1]
  def change
    create_table :museums do |t|
      t.string :name
      t.text :about
      t.string :email
      t.string :phone
      t.string :page
      t.string :address
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
