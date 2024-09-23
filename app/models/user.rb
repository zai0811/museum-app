class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :invitees, class_name: 'User', foreign_key: :invited_by_id
  has_many :museums
  has_many :museum_registration_requests
  has_one_attached :profile_picture

  validates_presence_of :email,
                        :first_name,
                        :last_name,
                        :phone_number,
                        :ci
  validates_uniqueness_of :email
  validates :profile_picture, image: true
  def self.ransackable_attributes(auth_object = nil)
    %w[ email first_name last_name phone_number ci created_at ]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def museums_count
    self.museums.count
  end

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
