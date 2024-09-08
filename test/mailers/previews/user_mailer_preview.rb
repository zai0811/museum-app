# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  def new_museum_registration_request
    UserMailer.with(museum_registration_request: MuseumRegistrationRequest.first).new_museum_registration_request
  end

  def new_museum_registration_request_user
    UserMailer.with(museum_registration_request: MuseumRegistrationRequest.first).new_museum_registration_request_user
  end
  def approved_museum_registration_request
    UserMailer.with(museum_registration_request: MuseumRegistrationRequest.first).approved_museum_registration_request
  end

  def rejected_museum_registration_request
    UserMailer.with(museum_registration_request: MuseumRegistrationRequest.last).rejected_museum_registration_request
  end
end
