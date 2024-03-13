class MuseumRegistrationRequest < ApplicationRecord
  enum :registration_status, { not_reviewed: 0, approved: 1, rejected: 2, archived: 3}, default: :not_reviewed
end
