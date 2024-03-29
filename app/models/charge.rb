class Charge < ApplicationRecord
  belongs_to :invoice
  has_one :membership, through: :invoice
end
