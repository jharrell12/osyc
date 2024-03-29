class Phone < ApplicationRecord
  belongs_to :person
  has_one :membership, through: :people
end
