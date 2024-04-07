class Address < ApplicationRecord
  belongs_to :person
  has_one :membership, through: :people
  include StartEndDates
  
  validates_presence_of :label

  normalizes :street, with: -> { _1.strip.titleize }
  normalizes :city, with: -> { _1.strip.titleize }
  normalizes :label, with: -> { _1.strip.titleize }
    
end
