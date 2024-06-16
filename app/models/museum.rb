class Museum < ApplicationRecord
  NOT_PUBLISHED = 0
  PUBLISHED = 1
  ARCHIVED = 2

  belongs_to :user
  belongs_to :museum_registration_request
  belongs_to :department
  belongs_to :city
  has_many :piece_collections
  has_many :pieces, through: :piece_collections
  validates_presence_of :name, :code, :city, :department

  enum :status, { hidden: NOT_PUBLISHED, published: PUBLISHED, archived: ARCHIVED}, default: :hidden

  def update_status!(status)
    return false unless status.in?([ NOT_PUBLISHED, PUBLISHED, ARCHIVED ])
    update!(status: status)
    true
  end
end
