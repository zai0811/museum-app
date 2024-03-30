class MuseumRegistrationRequest < ApplicationRecord
  NOT_REVIEWED = 0
  APPROVED = 1
  REJECTED = 2
  ARCHIVED = 3

  has_one :museum
  enum :registration_status, { not_reviewed: NOT_REVIEWED, approved: APPROVED, rejected: REJECTED, archived: ARCHIVED }, default: :not_reviewed
  validates_presence_of :manager_email, :manager_name, :museum_name, :museum_code, :museum_address

  def update_registration_status!(status)
    return false unless valid_status?(status)
    if status == APPROVED
      approve_registration_request!
    end
    update!(registration_status: status)
    true
  end

  private

  def valid_status?(status)
    status.in?([ APPROVED, REJECTED, ARCHIVED ])
  end

  def approve_registration_request!
    if Museum.exists?(code: museum_code)
      #todo add i18n new yml for each object
      raise StandardError, I18n.t("activerecord.errors.messages.museum_taken")
    end

    ActiveRecord::Base.transaction do
      user = find_or_invite_user!
      Museum.create!(name: museum_name, code: museum_code, address: museum_address, user_id: user.id, museum_registration_request_id: id)
    end
  end

  def find_or_invite_user!
    user = User.find_by(email: manager_email)
    unless user
      #TODO should do User.getAdminID or ignore the invited_by?
      user = User.invite!(email: manager_email)
    end
    user
  end

end
