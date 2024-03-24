json.extract! email, :id, :person_id, :start_date, :end_date, :label, :address, :created_at, :updated_at
json.url email_url(email, format: :json)
