class Membership < ApplicationRecord
    has_many :people
    has_many :invoices
end
