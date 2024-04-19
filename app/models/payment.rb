class Payment < ApplicationRecord
  belongs_to :invoice, touch: true
  has_one :membership, through: :invoice
  validates_presence_of :date
  validates :amount, numericality: { greater_than: 0 }

  def payment_str
    "$" + [amount, check_number].join(' : ')
  end
end
