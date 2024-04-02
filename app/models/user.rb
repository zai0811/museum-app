class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :invitees, class_name: 'User', foreign_key: :invited_by_id
  has_many :museums
  has_many :museum_registration_requests
  validates_presence_of :email

  def museum_owner?(museum)
    museum.in?(museums)
  end

  def admin_or_museum_owner?(museum)
    admin? || museum_owner?(museum)
  end

  def museum_registration_request_owner?(registration_request)
    registration_request.in?(museum_registration_requests)
  end

  def admin_or_museum_registration_request_owner?(registration_request)
    admin? || museum_registration_request_owner?(registration_request)
  end

end
