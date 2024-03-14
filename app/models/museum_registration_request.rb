class MuseumRegistrationRequest < ApplicationRecord
  # USAR CONSNTANTES EN VEZ DE VALORES FLOTANTES
  enum :registration_status, { not_reviewed: 0, approved: 1, rejected: 2, archived: 3}, default: :not_reviewed
  validates_presence_of :manager_email, :museum_name, :museum_code, :museum_address

  def accept_registration_request
    user_email = self.manager_email
    museum_name = self.museum_name
    museum_code = self.museum_code
    museum_address = self.museum_address

    user = User.find_by(email: user_email)

    # ver como hacer que no sea la contraseña requerida
    # usar transacciones (toleracia de errores)
    # manejo de excepciones jajsjsjsidj
    if user.nil?
      user = User.create!(email: user_email, password: "temporary_password", password_confirmation: "temporary_password")
    end
    #validar que el museo ya existe ? EL CODIGO DEBE SER UNIKOOO
    Museum.create!(name: museum_name, code: museum_code, address: museum_address, user_id: user.id)
  end
end
