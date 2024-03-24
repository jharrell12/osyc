json.extract! membership, :id, :start_date, :end_date, :status, :boats, :slip_assignment, :children, :created_at, :updated_at
json.url membership_url(membership, format: :json)
