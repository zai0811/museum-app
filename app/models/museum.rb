class Museum < ApplicationRecord
  belongs_to :user, optional: true
  enum :museum_status, { draft: 0, published: 2, archived: 3}, default: :draft
  validates_presence_of :name
  validates_presence_of :code


end
