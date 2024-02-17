class Museum < ApplicationRecord
  belongs_to :user, optional: true
end
