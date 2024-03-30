json.extract! museum, :id, :name, :about, :email, :phone, :page, :address, :user_id, :created_at, :updated_at, :museum_registration_requests_id
json.url museum_url(museum, format: :json)
