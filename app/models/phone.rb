class Phone < ApplicationRecord
  belongs_to :person
  has_one :membership, through: :people
  attribute :start_date, default: -> { Date.today }
  validates_presence_of :start_date
  validates_presence_of :label
  validates_presence_of :number

  #before_save :number_str
  normalizes :number, with: -> { _1.format_phone_number }
  
  scope :current,         -> { where("(end_date is null) OR DATE(end_date) >= DATE('now')") }

  def number_str
    number.format_phone_number 
  end

  def phone_str
    [label, number_str].join(': ')
  end

end
