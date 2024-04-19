class Payment < ApplicationRecord
  belongs_to :invoice
  has_one :membership, through: :invoice
  validates_presence_of :date
  validates :amount, numericality: { greater_than: 0 }

  after_save :calculate_balance_due

  def calculate_balance_due
    self.invoice.save
  end

  def payment_str
    "$" + [amount, check_number].join(' : ')
  end
end
