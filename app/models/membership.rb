class Membership < ApplicationRecord
    has_many :people, dependent: :destroy
    has_many :invoices, dependent: :destroy
end
