json.extract! charge, :id, :invoice_id, :description, :price, :created_at, :updated_at
json.url charge_url(charge, format: :json)
