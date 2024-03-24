json.extract! payment, :id, :invoice_id, :date, :amount, :check_number, :created_at, :updated_at
json.url payment_url(payment, format: :json)
