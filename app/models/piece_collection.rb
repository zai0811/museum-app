class PieceCollection < ApplicationRecord
  belongs_to :museum
  has_many :pieces
  validates_presence_of :name
end
