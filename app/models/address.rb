class Address < ApplicationRecord
  belongs_to :person
  has_one :membership, through: :people
  attribute :start_date, default: -> { Date.today }
  validates_presence_of :start_date
  validates_presence_of :label

  normalizes :street, with: -> { _1.strip.titleize }
  normalizes :city, with: -> { _1.strip.titleize }

  scope :current,         -> { where("(end_date is null) OR DATE(end_date) >= DATE('now')") }

end
