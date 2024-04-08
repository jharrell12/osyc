namespace :demo do
  desc "Remove fake demo data"
  task remove_data: :environment do 
    Membership.where(children: 'demo').map(&:destroy!)
  end

  desc "Create fake demo data"
  task create_data: :environment do
    10.times do 
      m = Membership.create!(fake_membership_hash)
      p1 = m.people.create!(fake_person_hash(:m))
      p2 = m.people.create!(fake_person_hash(:f, p1.last_name))
      p1.addresses.create!(fake_mailing_address(m.start_date))
      p1.emails.create!(fake_email_address(m.start_date, p1.first_name))
      p1.phones.create!(fake_cell_phone(m.start_date))
      p2.emails.create!(fake_email_address(m.start_date, p2.first_name))
      p2.phones.create!(fake_cell_phone(m.start_date))
    end
  end

  def fake_membership_hash
    {
      status: 'Active',
      start_date: Faker::Date.between(from: '1995-01-01', to: '2023-12-15'),
      boats: Faker::FunnyName.two_word_name,
      children: 'demo',
    }
  end

  def fake_person_hash(gen, last_name = nil)
    {
      last_name: last_name || Faker::Name.last_name,
      first_name: (gen == :m ? Faker::Name.male_first_name : Faker::Name.female_first_name),
      dob: Faker::Date.birthday(min_age: 32),
    }
  end

  def fake_cell_phone(start_date)
    {
      start_date: start_date,
      label: 'Cell',
      number: Faker::PhoneNumber.cell_phone,
    }
  end

  def fake_email_address(start_date, first_name)
    {
      start_date: start_date,
      label: 'Main',
      address: "#{first_name}@example.com"
    }
  end

  def fake_mailing_address(start_date)
    {
      start_date: start_date,
      label: 'Mail',
      street: Faker::Address.street_address,
      city: Faker::Address.city,
      state: Faker::Address.state_abbr,
      zipcode: Faker::Address.zip_code,
    }
  end


end
