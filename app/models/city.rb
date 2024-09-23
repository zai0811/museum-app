class City < ApplicationRecord
  belongs_to :department
  validates_presence_of :name

  def self.ransackable_attributes(auth_object = nil)
    %w[id name]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end
