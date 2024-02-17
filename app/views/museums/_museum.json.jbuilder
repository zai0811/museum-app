json.extract! museum, :id, :name, :about, :email, :phone, :page, :address, :user_id, :created_at, :updated_at
json.url museum_url(museum, format: :json)
