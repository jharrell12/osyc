class Invoice < ApplicationRecord
  belongs_to :membership
  has_many :charges, dependent: :destroy
  has_many :payments, dependent: :destroy
end
