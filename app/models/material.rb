class Material < ApplicationRecord
  has_many :pieces
  validates_presence_of :name
  validates_uniqueness_of :name

  def self.ransackable_attributes(auth_object = nil)
    %w[id name]
  end

  def self.ransackable_associations(auth_object = nil)
    ["piece"]
  end
end
