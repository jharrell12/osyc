json.extract! person, :id, :membership_id, :first_name, :last_name, :dob, :birth_year, :created_at, :updated_at
json.url person_url(person, format: :json)
