class Payment < ApplicationRecord
  belongs_to :invoice
  has_one :membership, through: :invoice
  validates_presence_of :date
  validates :amount, numericality: { greater_than: 0 }
end
