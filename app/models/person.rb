class Person < ApplicationRecord
  belongs_to :membership
  has_many :emails, dependent: :destroy
  has_many :phones, dependent: :destroy
  has_many :addresses, dependent: :destroy

  validates_presence_of :last_name
  normalizes :last_name, with: -> { _1.strip.titleize }
  normalizes :first_name, with: -> { _1.strip.titleize }

  validates :dob, comparison: { greater_than: '1900-01-01'.to_date, less_than_or_equal_to: Date.today }, allow_blank: true
  validates :birth_year, comparison: { greater_than: 1900, less_than_or_equal_to: Date.today.year}, allow_blank: true

  def last_name_first
    [last_name, first_name].join(', ')
  end

  def full_name
    [first_name, last_name].join(' ')
  end

  def emails_str(sep = ', ')
    emails.collect{|e| e.address}.join(sep)
  end

  def phones_str(sep = ', ')
    phones.collect{|phone| phone.phone_str}.join(sep)
  end
end
