class Phone < ApplicationRecord
  belongs_to :person
  has_one :membership, through: :people
  attribute :start_date, default: -> { Date.today }
  validates_presence_of :start_date
  validates_presence_of :label
  validates_presence_of :number

  before_save :format_phone_number
  
  def format_phone_number
    if (digits = number.scan(/\d+/).join).size == 10 && !(number =~ /[A-Z]|[a-z]/)
      number = "#{digits[0,3]}-#{digits[3,3]}-#{digits[6,4]}"
    else
      number
    end  
  end

end
