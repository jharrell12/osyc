class Membership < ApplicationRecord
  has_many :people, dependent: :destroy
  has_many :emails, -> { sorted }, through: :people
  has_many :phones, -> { sorted }, through: :people
  has_many :addresses, -> { sorted }, through: :people

  has_many :invoices, dependent: :destroy
  has_many :charges, through: :invoices
  has_many :payments, through: :invoices
  include StartEndDates

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

  def names
    if people.collect(&:last_name).uniq.size == 1
      [people.map(&:first_name).join(' & '), people.first.last_name].join(' ')
    else
      people.collect{|person| person.full_name}.join(' and ')
    end
  end

  def active_emails_strs
    people.map{|person| person.emails.current}.flatten.collect{|e| e.address.to_nb}
  end

  def active_phones_strs
    people.map{|person| person.phones.current}.flatten.collect{|phone| "#{phone.label}: #{phone.number_str} #{phone.person.first_name} ".to_nb}
  end

end
