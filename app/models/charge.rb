class Charge < ApplicationRecord
  belongs_to :invoice
  has_one :membership, through: :invoice
  validates_presence_of :description
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  after_save :calculate_balance_due

  def calculate_balance_due
    self.invoice.save
  end

  def charge_str
    "$" + [price, description].join(' : ')
  end
end
