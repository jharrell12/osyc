class Email < ApplicationRecord
  belongs_to :person
  has_one :membership, through: :people

  validates_format_of: :address, with: URI::MailTo::EMAIL_REGEXP
end
