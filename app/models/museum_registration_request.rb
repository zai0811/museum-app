class MuseumRegistrationRequest < ApplicationRecord
  NOT_REVIEWED = 0
  APPROVED = 1
  REJECTED = 2
  ARCHIVED = 3
  FILE_SIZE_LIMIT = 5

  has_one :museum
  belongs_to :created_by, class_name: "User", optional: true
  belongs_to :updated_by, class_name: "User", optional: true
  belongs_to :department
  belongs_to :city
  has_one_attached :registration_doc

  enum :registration_status, { not_reviewed: NOT_REVIEWED, approved: APPROVED, rejected: REJECTED, archived: ARCHIVED }, default: :not_reviewed
  validates :museum_name, length: { in: 5..50 }
  validates_presence_of :manager_email,
                        :museum_name,
                        :museum_address,
                        :first_name,
                        :last_name,
                        :ci,
                        :department_id,
                        :city_id,
                        :museum_code
  validate :valid_registration_doc

  after_save :check_registration_status!
  scope :active_status, -> { where(registration_status: [NOT_REVIEWED, APPROVED, REJECTED]) }

  def self.ransackable_attributes(auth_object = nil)
    ["museum_name", "registration_status", "manager_email", "created_at", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["city"]
  end

  def valid_registration_doc
    unless registration_doc.attached?
      errors.add(:registration_doc, "debe existir")
      return
    end

    unless registration_doc.byte_size <= FILE_SIZE_LIMIT.megabyte
      errors.add(:registration_doc, "excede el límite de #{FILE_SIZE_LIMIT} MB")
    end
    unless registration_doc.content_type ==  "application/pdf"
      errors.add(:registration_doc, "debe ser de tipo PDF")
    end
  end

  # Should not perform further updates to approved requests
  def check_registration_status!
    if self.approved?
      process_approval!
    end
  rescue StandardError => error
    errors.add(:base, "Error configurando usuario y museo, los cambios no han sido guardados. Favor contactar a soporte técnico. Error: #{error.message} #{error.class}." )
    raise ActiveRecord::RecordInvalid.new(self)
  end

  def departments
    Department.all
  end

  def cities
    City.find_by(department: department)
  end

  private

  # invite user and create museum
  def process_approval!
    ActiveRecord::Base.transaction do
      user = find_or_invite_user!
      Museum.create!(name: museum_name, code: museum_code, address: museum_address, user_id: user.id, museum_registration_request_id: id, department_id: department_id, city_id: city_id)
    end
  end

  def find_or_invite_user!
    user = User.find_by(email: manager_email)
    return user if user

    User.invite!(email: manager_email, first_name: first_name, last_name: last_name, ci: ci, phone_number: phone_number)
  end
end
