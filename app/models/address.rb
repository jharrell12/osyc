class Address < ApplicationRecord
  belongs_to :person
  has_one :membership, through: :people
  
  attribute :start_date, default: -> { Date.today }
  
  validates_presence_of :start_date
  validates :end_date, comparison: { greater_than: :start_date }, allow_blank: true
  validates_presence_of :label

  normalizes :street, with: -> { _1.strip.titleize }
  normalizes :city, with: -> { _1.strip.titleize }
  normalizes :label, with: -> { _1.strip.titleize }

  scope :current,         -> { where("(end_date is null) OR DATE(end_date) >= DATE('now')") }

  def current? = end_date.nil? || end_date > Date.today
    
end
