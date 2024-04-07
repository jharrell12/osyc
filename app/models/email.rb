class Email < ApplicationRecord
  belongs_to :person
  has_one :membership, through: :people
  include StartEndDates

  validates_presence_of :label
  validates_presence_of :address
  validates_format_of :address, with: URI::MailTo::EMAIL_REGEXP
  
  normalizes :address, with: -> { _1.strip.downcase }
  normalizes :label, with: -> { _1.strip.titleize }

end
