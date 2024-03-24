class MuseumRegistrationRequest < ApplicationRecord
  NOT_REVIEWED = 0
  APPROVED = 1
  REJECTED = 2
  ARCHIVED = 3

  enum :registration_status, { not_reviewed: NOT_REVIEWED, approved: APPROVED, rejected: REJECTED, archived: ARCHIVED }, default: :not_reviewed
  validates_presence_of :manager_email, :manager_name, :museum_name, :museum_code, :museum_address

  def accept_registration_request!
    if Museum.exists?(code: museum_code)
      raise StandardError, "El museo ya existe! No se puede procesar la aceptación de esta solicitud."
    end

    ActiveRecord::Base.transaction do
      update_registration_status(APPROVED)
      user = find_or_invite_user!
      Museum.create!(name: museum_name, code: museum_code, address: museum_address, user_id: user.id)
    end
  end

  def update_registration_status(status)
    self.update!(registration_status: status)
  end

  private

  def find_or_invite_user!
    user = User.find_by(email: manager_email)
    unless user
      #TODO should do User.getAdminID or ignore the invited_by
      user = User.invite!(email: manager_email)
    end
    user
  end
end
