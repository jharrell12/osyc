class Phone < ApplicationRecord
  include StartEndDates
  belongs_to :person
  has_one :membership, through: :people
  
  validates_presence_of :label
  validates_presence_of :number

  normalizes :number, with: -> { _1.format_phone_number }
  normalizes :label, with: -> { _1.strip.titleize }
  
  def number_str
    number.format_phone_number 
  end

  def phone_str
    [label, number_str].join(': ')
  end

end
