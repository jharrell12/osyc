class Invoice < ApplicationRecord
  belongs_to :membership
  has_many :charges
  has_many :payments
end
