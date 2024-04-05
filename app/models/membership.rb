class Membership < ApplicationRecord
  include TruncateStringColumns
  include TimestampStrings

  has_many :people, dependent: :destroy
  has_many :emails, through: :people
  has_many :phones, through: :people
  has_many :addresses, through: :people

  has_many :invoices, dependent: :destroy
  has_many :charges, through: :invoices
  has_many :payments, through: :invoices

  attribute :start_date, default: -> { Date.today }
  attribute :status, default: -> { VALID_STATUSES.first }

  truncate_strings :status, :boats, :slip_assignment, :children
  strip_strings :status, :boats, :slip_assignment, :children

  validates_presence_of :start_date
  validate :validate_status
  validates :end_date, comparison: { greater_than: :start_date }, allow_blank: true

  VALID_STATUSES = %w(new applied posted accepted active inactive resigned deleted).map(&:titleize)

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
