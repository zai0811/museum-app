class Piece < ApplicationRecord
  NOT_PUBLISHED = 0
  PUBLISHED = 1
  ARCHIVED = 2

  belongs_to :piece_collection
  has_one :museum, through: :piece_collection
  belongs_to :material, optional: true
  belongs_to :author, optional: true
  belongs_to :object_type, optional: true
  has_one_attached :image

  validates_presence_of :name
  validates :image, image: true

  enum :status, { hidden: NOT_PUBLISHED, published: PUBLISHED, archived: ARCHIVED }, default: :hidden

  def self.ransackable_attributes(auth_object = nil)
    %w[name description status created_at updated_at in_display]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[piece_collection museum author material object_type]
  end

  def self.published
    joins(piece_collection: :museum)
      .where({ museums: { status: PUBLISHED } })
      .where({ piece_collections: { status: PUBLISHED } })
      .where(status: PUBLISHED) || []
  end

  def update_status!(status)
    return false unless status.in?([NOT_PUBLISHED, PUBLISHED, ARCHIVED])
    update!(status: status)
    true
  end

  def unarchived_pieces
    where.not(status: ARCHIVED)
  end
end