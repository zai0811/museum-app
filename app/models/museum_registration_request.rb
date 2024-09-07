class MuseumRegistrationRequest < ApplicationRecord
  NOT_REVIEWED = 0
  APPROVED = 1
  REJECTED = 2
  ARCHIVED = 3

  has_one :museum
  belongs_to :created_by, class_name: "User", optional: true
  belongs_to :updated_by, class_name: "User", optional: true
  belongs_to :department
  belongs_to :city
  has_one_attached :registration_doc

  enum :registration_status, { not_reviewed: NOT_REVIEWED, approved: APPROVED, rejected: REJECTED, archived: ARCHIVED }, default: :not_reviewed
  validates_presence_of :manager_email, :museum_name, :museum_address, :first_name, :last_name, :ci
  after_save :check_registration_status!

  scope :active_status, -> { where(registration_status: [NOT_REVIEWED, APPROVED, REJECTED]) }

  def check_registration_status!
    if self.approved?
      process_approval!
    end
  end

  def departments
    Department.all
  end

  def cities
    City.find_by(department: department)
  end

  private

  # invite user and create museum
  # @todo test scenarios where this fails and handle them correctly
  def process_approval!
    ActiveRecord::Base.transaction do
      user = find_or_invite_user!
      Museum.create!(name: museum_name, code: museum_code, address: museum_address, user_id: user.id, museum_registration_request_id: id, department_id: department_id, city_id: city_id)
    end
  end

  def find_or_invite_user!
    user = User.find_by(email: manager_email)
    unless user
      user = User.invite!(email: manager_email, first_name: first_name, last_name: last_name, ci: ci, phone_number: phone_number)
    end
    update!(created_by: user) unless created_by
    user
  end

end
