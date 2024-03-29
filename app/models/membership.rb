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



  truncate_strings :status, :boats, :slip_assignment, :children
  strip_strings :status, :boats, :slip_assignment, :children

  validates_presence_of :start_date
  validate :validate_status

  VALID_STATUSES = %w(new applied posted accepted active inactive resigned deleted).map(&:titleize)

  def validate_status
    if !VALID_STATUSES.include?(status)
      errors.add(:status, "must be one of #{VALID_STATUSES}")
    end
  end

  def self.status_options_for_select
    VALID_STATUSES
  end
  #--------------------------------------------------------------
  def initialize(vals = nil)
    vals ||= Hash.new
    vals[:start_date] ||= Date.today
    vals[:status] ||= VALID_STATUSES.first
    super(vals)
  end
end
