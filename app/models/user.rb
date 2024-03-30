class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :invitees, class_name: 'User', foreign_key: :invited_by_id
  has_many :museums
  validates_presence_of :email

  def owner?(museum)
    museum.in?(museums)
  end

  def owner_or_admin?(museum)
    admin? || owner?(museum)
  end
end
