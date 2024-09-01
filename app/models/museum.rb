class Museum < ApplicationRecord
  NOT_PUBLISHED = 0
  PUBLISHED = 1
  ARCHIVED = 2

  enum :status, { hidden: NOT_PUBLISHED, published: PUBLISHED, archived: ARCHIVED }, default: :hidden

  belongs_to :user
  belongs_to :museum_registration_request
  belongs_to :department
  belongs_to :city
  has_many :piece_collections
  has_many :pieces, through: :piece_collections
  has_one_attached :image

  validates_presence_of :name, :code, :city, :department
  validates :latitude, numericality: { greater_than_or_equal_to: -90, less_than_or_equal_to: 90 }
  validates :longitude, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }

  def self.ransackable_attributes(auth_object = nil)
    ["name", "about", "address"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["city"]
  end

  def update_status!(status)
    return false unless status.in?([NOT_PUBLISHED, PUBLISHED, ARCHIVED])
    update!(status: status)
    true
  end
end
