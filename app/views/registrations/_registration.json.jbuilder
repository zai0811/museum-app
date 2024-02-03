json.extract! registration, :id, :manager_email, :museum_name, :created_at, :updated_at
json.url registration_url(registration, format: :json)
