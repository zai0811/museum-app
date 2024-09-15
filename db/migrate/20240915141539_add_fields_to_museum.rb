class AddFieldsToMuseum < ActiveRecord::Migration[7.1]
  def change
    add_column :museums, :free_entrance, :boolean, :default => true
    add_column :museums, :entrance_price, :string
    add_column :museums, :schedule, :text
    add_column :museums, :accessibility_features, :text
  end
end
