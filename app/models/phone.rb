class Phone < ApplicationRecord
  belongs_to :person
  has_one :membership, through: :people
  
  attribute :start_date, default: -> { Date.today }

  validates_presence_of :start_date
  validates :end_date, comparison: { greater_than: :start_date }, allow_blank: true
  validates_presence_of :label
  validates_presence_of :number

  normalizes :number, with: -> { _1.format_phone_number }
  normalizes :label, with: -> { _1.strip.titleize }
  
  scope :current,         -> { where("(end_date is null) OR DATE(end_date) >= DATE('now')") }

  def number_str
    number.format_phone_number 
  end

  def phone_str
    [label, number_str].join(': ')
  end

  def current?
    end_date.nil? #|| end_date <= Date.today
  end
end
