class Department < ApplicationRecord
  validates_presence_of :name
  has_many :cities

  def self.ransackable_attributes(auth_object = nil)
    %w[id name]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end
