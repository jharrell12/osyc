json.extract! invoice, :id, :membership_id, :status, :posted_date, :due_date, :balance_due, :created_at, :updated_at
json.url invoice_url(invoice, format: :json)
