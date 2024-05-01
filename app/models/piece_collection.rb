class PieceCollection < ApplicationRecord
  belongs_to :museum
  validates_presence_of :name
end
