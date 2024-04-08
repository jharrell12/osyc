class Address < ApplicationRecord
  belongs_to :person
  has_one :membership, through: :person
  include StartEndDates
  
  validates_presence_of :label

  normalizes :street, with: -> { _1.strip.titleize }
  normalizes :city, with: -> { _1.strip.titleize }
  normalizes :state, with: -> { _1.strip.upcase }
  normalizes :label, with: -> { _1.strip.titleize }

end
