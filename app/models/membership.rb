class Membership < ApplicationRecord
  has_many :people, dependent: :destroy
  has_many :emails, -> { sorted }, through: :people
  has_many :phones, -> { sorted }, through: :people
  has_many :addresses, -> { sorted }, through: :people

  has_many :invoices, dependent: :destroy
  has_many :charges, through: :invoices
  has_many :payments, through: :invoices
  include StartEndDates
  scope :sorted, -> { order(end_date: :asc, status: :asc, start_date: :desc) }
  scope :current,         -> { where("(end_date is null) OR DATE(end_date) > DATE('now')") }
  scope :active,         -> { current.where(status: 'Active') }

  attribute :status, default: -> { VALID_STATUSES.first }

  truncate_strings :status, :boats, :slip_assignment, :children
  strip_strings :status, :boats, :slip_assignment, :children

  validate :validate_status

  VALID_STATUSES = %w(inquiry applied posted accepted active inactive resigned deleted).map(&:titleize)

  def validate_status
    if !VALID_STATUSES.include?(status)
      errors.add(:status, "must be one of #{VALID_STATUSES}")
    end
  end

  def self.status_options_for_select
    VALID_STATUSES
  end

  def has_slip?
    slip_assignment.present?
  end

  def unique_last_names
    people.collect(&:last_name).compact.uniq
  end

  def last_name
    unique_last_names.size == 1 ? people.first.last_name : nil
  end

  def last_names
    unique_last_names.join(' and ')
  end

  def first_names
    if unique_last_names.size == 1
      people.map(&:first_name).join(' & ')
    else
      people.collect{|person| person.full_name}.join(' and ')
    end
  end

  def names
    if unique_last_names.size == 1
      [people.map(&:first_name).join(' & '), people.first.last_name].join(' ')
    else
      people.collect{|person| person.full_name}.join(' and ')
    end
  end

  def active_emails_strs
    #people.map{|person| person.emails.current}.flatten.collect{|e| e.address.to_nb}
    #emails.current.collect{|e| e.address.to_nb}

    # refactored to avoid n+1 query on index page
    emails.select{|e| e.current?}.collect{|e| e.address.to_nb}
  end

  def active_phones_strs
    #people.map{|person| person.phones.current}.flatten.collect{|phone| "#{phone.label}: #{phone.number_str} #{phone.person.first_name} ".to_nb}
    #phones.current.collect{|phone| "#{phone.label}: #{phone.number_str} #{phone.person.first_name} ".to_nb}
    
    # refactored to avoid n+1 query on index page
    phones.select{|phone| phone.current?}.collect{|phone| "#{phone.label}: #{phone.number_str} #{phone.person.first_name} ".to_nb} 
  end

end
