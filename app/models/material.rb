class Material < ApplicationRecord
  has_many :pieces

  def self.ransackable_attributes(auth_object = nil)
    %w[id name]
  end

  def self.ransackable_associations(auth_object = nil)
    ["piece"]
  end
end
