class Museum < ApplicationRecord
  belongs_to :user
  belongs_to :museum_registration_request
  validates_presence_of :name, :code

  enum :museum_status, { draft: 0, published: 2, archived: 3}, default: :draft
end
