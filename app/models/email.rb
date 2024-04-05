class Email < ApplicationRecord
  belongs_to :person
  has_one :membership, through: :people

  attribute :start_date, default: -> { Date.today }

  validates_presence_of :start_date
  validates_presence_of :label
  validates_presence_of :address
  validates_format_of :address, with: URI::MailTo::EMAIL_REGEXP

  normalizes :address, with: -> { _1.strip.downcase }
end
