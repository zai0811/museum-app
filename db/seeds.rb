# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Create departments
departments = [
  { name: 'Central' },
  { name: 'Itapúa' },
]

departments.each do |department|
  Department.find_or_create_by!(department)
end

# Create cities
cities = [
  { name: 'Asunción', department_id: Department.find_by(name: 'Capital').id },
  { name: 'Encarnación', department_id: Department.find_by(name: 'Itapúa').id },
# Add more cities as needed
]

cities.each do |city|
  City.find_or_create_by!(city)
end

# Create default admin user
admin_user = User.find_or_initialize_by(email: 'admin@com.com')
admin_user.assign_attributes(first_name: "System", last_name: "Admin", password: 'admin_pass', password_confirmation: 'admin_pass', admin: true)
admin_user.save!

materials = [{ name: 'Barro' }, { name: 'Cerámica' }, { name: 'Hierro' }, { name: 'Porcelana' }, { name: 'Plástico' }, { name: 'Vidrio' }, { name: 'Tela' }, { name: 'Tela' }]

materials.each do |material|
  Material.find_or_create_by!(material)
end