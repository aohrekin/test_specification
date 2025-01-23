json.extract! user, :id, :name, :patronymic, :email, :age, :country, :gender, :surname, :created_at, :updated_at
json.url user_url(user, format: :json)
