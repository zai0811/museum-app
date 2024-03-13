json.extract! museum_registration_request, :id, :registration_status , :museum_name, :museum_code, :museum_address, :manager_email, :manager_name, :created_at, :updated_at
json.url museum_registration_request_url(museum_registration_request, format: :json)
