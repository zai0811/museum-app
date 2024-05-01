class Museum < ApplicationRecord
  DRAFT = 0
  PUBLISHED = 1
  ARCHIVED = 2

  belongs_to :user
  belongs_to :museum_registration_request
  belongs_to :department
  belongs_to :city
  has_many :piece_collections
  has_many :pieces, through: :piece_collections
  validates_presence_of :name, :code, :city, :department

  enum :museum_status, { draft: DRAFT, published: PUBLISHED, archived: ARCHIVED}, default: :draft
end
