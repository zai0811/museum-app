class PieceCollection < ApplicationRecord
  NOT_PUBLISHED = 0
  PUBLISHED = 1
  ARCHIVED = 2

  belongs_to :museum
  has_many :pieces
  validates_presence_of :name

  enum :status, { hidden: NOT_PUBLISHED, published: PUBLISHED, archived: ARCHIVED }, default: :hidden

  def published_pieces_count
    pieces.where(status: PUBLISHED).count
  end

  def pieces_count
    pieces.count
  end
  def update_status!(status)
    return false unless status.in?([NOT_PUBLISHED, PUBLISHED, ARCHIVED])
    update!(status: status)
    true
  end

  def get_background_image
    unless pieces.empty?
      pieces.each do |p|
        if p.image.attached? && p.published?
          return p
        end
      end
    end
    nil
  end
end