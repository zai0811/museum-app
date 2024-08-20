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
  has_one_attached :image

  enum :status, { hidden: NOT_PUBLISHED, published: PUBLISHED, archived: ARCHIVED }, default: :hidden

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

  def get_collection_background_image
    unless piece_collections.empty?
      piece_collections.each do |pc|
        pc_background = pc.get_background_image
        if pc_background && pc.published?
          return pc_background
        end
      end
    end
    nil
  end
end
