class UserMailer < ApplicationMailer
  default from: 'MuseumApp <no-reply@museumapp.com>'

  def new_museum_registration_request
    @museum_registration_request = params[:museum_registration_request]
    @full_name = "#{@museum_registration_request.first_name} #{@museum_registration_request.last_name}"
    @email = @museum_registration_request.manager_email
    @museum_name = @museum_registration_request.museum_name
    @created_by = @museum_registration_request.created_by

    @admin = User.find_by_admin(true)
    mail(
      to: @admin.email,
      subject: 'Nueva Solicitud de Registro'
    )
  end

  def new_museum_registration_request_user
    @museum_registration_request = params[:museum_registration_request]
    @full_name = "#{@museum_registration_request.first_name} #{@museum_registration_request.last_name}"
    @email = @museum_registration_request.manager_email
    @museum_name = @museum_registration_request.museum_name

    mail(
      to:  email_address_with_name(@museum_registration_request.manager_email, @full_name),
      subject: 'Nueva Solicitud de Registro'
    )

  end

  def approved_museum_registration_request
    @museum_registration_request = params[:museum_registration_request]
    @full_name = "#{@museum_registration_request.first_name} #{@museum_registration_request.last_name}"
    @museum_name = @museum_registration_request.museum_name
    mail(
      to: email_address_with_name(@museum_registration_request.manager_email, @full_name),
      subject: "Aceptación de Solicitud de Registro - #{@museum_name}"
    )
  end

  def rejected_museum_registration_request
    @museum_registration_request = params[:museum_registration_request]
    @full_name = "#{@museum_registration_request.first_name} #{@museum_registration_request.last_name}"
    @museum_name = @museum_registration_request.museum_name
    mail(
      to: email_address_with_name(@museum_registration_request.manager_email, @full_name),
      subject: "Solicitud de Registro Rechazada - #{@museum_name}"
    )
  end
end
