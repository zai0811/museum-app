class AddFeedbackToMuseumRegistrationRequest < ActiveRecord::Migration[7.1]
  def change
    add_column :museum_registration_requests, :feedback, :text
  end
end
