class Author < ApplicationRecord
  has_many :pieces

  def self.ransackable_attributes(auth_object = nil)
    %w[id first_name last_name full_name]
  end
  def self.ransackable_associations(auth_object = nil)
    ["piece"]
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def full_name_reversed
    "#{last_name}, #{first_name}"
  end
end
