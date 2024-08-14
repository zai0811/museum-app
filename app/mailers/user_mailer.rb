class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'
  def new_museum_registration_request
    @user = params[:user]
    mail(to: @user.email, subject: 'New registration request')
  end
end
