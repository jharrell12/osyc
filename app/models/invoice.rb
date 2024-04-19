class Invoice < ApplicationRecord
  belongs_to :membership
  has_many :charges, dependent: :destroy
  has_many :payments, dependent: :destroy
  attribute :status, default: -> { VALID_STATUSES.first }
  scope :pending,         -> { where(status: 'Pending') }
  scope :balance_due,     -> { pending.where("balance_due > 0")}

  VALID_STATUSES = %w(Draft Pending Paid Canceled).map(&:titleize)
  validate :validate_status

  before_save :calculate_balance_due
  after_touch :save

  def validate_status
    if !VALID_STATUSES.include?(status)
      errors.add(:status, "must be one of #{VALID_STATUSES}")
    end
  end

  def self.status_options_for_select
    VALID_STATUSES
  end

  def calculate_balance_due
    self.balance_due = charges.sum(:price) - payments.sum(:amount)
  end

  def draft?
    status == 'Draft'
  end

  def pending?
    status == 'Pending'
  end

  def zero_balance?
    calculate_balance_due == 0
  end

  def post!
    return false if !draft? || zero_balance?
    self.balance_due = calculate_balance_due
    self.status = 'Pending'
    self.posted_date = Time.now
    self.due_date = Date.today + 30.days
    save
  end


end
