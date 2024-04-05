class Person < ApplicationRecord
  belongs_to :membership
  has_many :emails, dependent: :destroy
  has_many :phones, dependent: :destroy
  has_many :addresses, dependent: :destroy

  validates_presence_of :last_name
  normalizes :last_name, with: -> { _1.strip.titleize }
  normalizes :first_name, with: -> { _1.strip.titleize }

  def last_name_first
    [last_name, first_name].join(', ')
  end

  def full_name
    [first_name, last_name].join(' ')
  end
end
